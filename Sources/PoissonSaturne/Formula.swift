import Foundation

struct Formula {
    let X:[Double]
    let Y:[Double]
    let Z:[Double]
}

extension Formula {

    func transform(point p: Point3D) -> Point3D {
        let monos: [Double] = [ 1.0, p.x, p.x * p.x, p.x * p.y, p.x * p.z, p.y, p.y * p.y, p.y * p.z, p.z, p.z * p.z ]
        let x = zip(monos, X).map({ $0.0 * $0.1 }).reduce(0, +)
        let y = zip(monos, Y).map({ $0.0 * $0.1 }).reduce(0, +)
        let z = zip(monos, Z).map({ $0.0 * $0.1 }).reduce(0, +)
        return Point3D(x:x, y:y, z:z)
    }
}
