import Foundation

typealias Formula = (_ p: Point3D) -> Point3D

protocol Factory {
    func create(from dict: [String: Any]) throws -> Formula
}

extension Factory {
    var name: String { return String(describing: type(of: self)) }
}

// MARK: - Each Factories

struct CliffordPickover3D: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let a = dict["a"] as? Double else { throw EnvelopeError.noKey("a") }
        guard let b = dict["b"] as? Double else { throw EnvelopeError.noKey("b") }
        guard let c = dict["c"] as? Double else { throw EnvelopeError.noKey("c") }
        guard let d = dict["d"] as? Double else { throw EnvelopeError.noKey("d") }
        guard let e = dict["e"] as? Double else { throw EnvelopeError.noKey("e") }
        return { (p: Point3D) -> Point3D in
            let x = sin(a*p.y) - p.z*cos(b*p.x)
            let y = p.z*sin(c*p.x) - cos(d*p.y)
            let z = e*sin(p.x)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct PeterDeJong3D: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let a = dict["a"] as? Double else { throw EnvelopeError.noKey("a") }
        guard let b = dict["b"] as? Double else { throw EnvelopeError.noKey("b") }
        guard let c = dict["c"] as? Double else { throw EnvelopeError.noKey("c") }
        guard let d = dict["d"] as? Double else { throw EnvelopeError.noKey("d") }
        guard let e = dict["e"] as? Double else { throw EnvelopeError.noKey("e") }
        guard let f = dict["f"] as? Double else { throw EnvelopeError.noKey("f") }
        return { (p: Point3D) -> Point3D in
            let x = sin(a * p.y) - cos(b * p.x)
            let y = sin(c * p.z) - cos(d * p.y)
            let z = sin(e * p.x) - cos(f * p.z)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial3: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let a = dict["a"] as? Double else { throw EnvelopeError.noKey("a") }
        guard let b = dict["b"] as? Double else { throw EnvelopeError.noKey("b") }
        guard let c = dict["c"] as? Double else { throw EnvelopeError.noKey("c") }
        return { (p: Point3D) -> Point3D in
            let x = a + p.y - p.y*p.z
            let y = b + p.z - p.x*p.z
            let z = c + p.x - p.x*p.y
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial6: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let a = dict["a"] as? Double else { throw EnvelopeError.noKey("a") }
        guard let b = dict["b"] as? Double else { throw EnvelopeError.noKey("b") }
        guard let c = dict["c"] as? Double else { throw EnvelopeError.noKey("c") }
        guard let d = dict["d"] as? Double else { throw EnvelopeError.noKey("d") }
        guard let e = dict["e"] as? Double else { throw EnvelopeError.noKey("e") }
        guard let f = dict["f"] as? Double else { throw EnvelopeError.noKey("f") }
        return { (p: Point3D) -> Point3D in
            let x = a + p.y - p.z*(b + p.y)
            let y = c + p.z - p.x*(d + p.z)
            let z = e + p.x - p.y*(f + p.x)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial18: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let X: [Double] = dict["X"] as? [Double] else { throw EnvelopeError.noKey("X") }
        guard let Y: [Double] = dict["Y"] as? [Double] else { throw EnvelopeError.noKey("Y") }
        guard let Z: [Double] = dict["Z"] as? [Double] else { throw EnvelopeError.noKey("Z") }
        return { (p: Point3D) -> Point3D in
            let x = X[0] + p.x*(X[1] + X[2]*p.x + X[3]*p.y) + p.y*(X[4] + X[5]*p.y)
            let y = Y[0] + p.y*(Y[1] + Y[2]*p.y + Y[3]*p.z) + p.z*(Y[4] + Y[5]*p.z)
            let z = Z[0] + p.z*(Z[1] + Z[2]*p.z + Z[3]*p.x) + p.x*(Z[4] + Z[5]*p.x)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial21: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let X: [Double] = dict["X"] as? [Double] else { throw EnvelopeError.noKey("X") }
        guard let Y: [Double] = dict["Y"] as? [Double] else { throw EnvelopeError.noKey("Y") }
        guard let Z: [Double] = dict["Z"] as? [Double] else { throw EnvelopeError.noKey("Z") }
        return { (p: Point3D) -> Point3D in
            let m: [Double] = [ 1.0, p.x, p.y, p.z, abs(p.x), abs(p.y), abs(p.z) ]
            let x = zip(m, X).map({ $0.0 * $0.1 }).reduce(0, +)
            let y = zip(m, Y).map({ $0.0 * $0.1 }).reduce(0, +)
            let z = zip(m, Z).map({ $0.0 * $0.1 }).reduce(0, +)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial24: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let X: [Double] = dict["X"] as? [Double] else { throw EnvelopeError.noKey("X") }
        guard let Y: [Double] = dict["Y"] as? [Double] else { throw EnvelopeError.noKey("Y") }
        guard let Z: [Double] = dict["Z"] as? [Double] else { throw EnvelopeError.noKey("Z") }
        return { (p: Point3D) -> Point3D in
            let m: [Double] = [ 1.0, p.x, p.y, p.z, abs(p.x), abs(p.y) ]
            let mx = m + [ pow(abs(p.z), X[7]) ]
            let my = m + [ pow(abs(p.z), Y[7]) ]
            let mz = m + [ pow(abs(p.z), Z[7]) ]
            let x = zip(mx, X).map({ $0.0 * $0.1 }).reduce(0, +)
            let y = zip(my, Y).map({ $0.0 * $0.1 }).reduce(0, +)
            let z = zip(mz, Z).map({ $0.0 * $0.1 }).reduce(0, +)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

struct Polynomial30: Factory {
    func create(from dict: [String: Any]) throws -> Formula {
        guard let X: [Double] = dict["X"] as? [Double] else { throw EnvelopeError.noKey("X") }
        guard let Y: [Double] = dict["Y"] as? [Double] else { throw EnvelopeError.noKey("Y") }
        guard let Z: [Double] = dict["Z"] as? [Double] else { throw EnvelopeError.noKey("Z") }
        return { (p: Point3D) -> Point3D in
            let monos: [Double] = [ 1.0, p.x, p.x * p.x, p.x * p.y, p.x * p.z, p.y, p.y * p.y, p.y * p.z, p.z, p.z * p.z ]
            let x = zip(monos, X).map({ $0.0 * $0.1 }).reduce(0, +)
            let y = zip(monos, Y).map({ $0.0 * $0.1 }).reduce(0, +)
            let z = zip(monos, Z).map({ $0.0 * $0.1 }).reduce(0, +)
            return Point3D(x: x, y: y, z: z)
        }
    }
}

// MARK: - Factory for Factory

class Factories {
    let map: [String: Factory]
    init(list: [Factory]) {
        self.map = list.reduce([String: Factory]()) { (d, f) in
            return d.merging([f.name: f]) { (_, new) in new }
        }
    }
    func obtain(name: String) -> Factory? { return map[name] }
    static let singleton = Factories(list: Factories.list)
    static let list: [Factory] = [
      CliffordPickover3D(),
      PeterDeJong3D(),
      Polynomial3(),
      Polynomial6(),
      Polynomial18(),
      Polynomial21(),
      Polynomial24(),
      Polynomial30(),
    ]
}
