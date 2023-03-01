import Foundation

typealias Formula = (_ p: Point3D) -> Point3D

protocol Factory {
    func create(from dict: [String: Any]) throws -> Formula
}
extension Factory {
    var name: String { return String(describing: type(of: self)) }
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
            return Point3D(x:x, y:y, z:z)
        }
    }
}

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
      Polynomial30(),
    ]
}
