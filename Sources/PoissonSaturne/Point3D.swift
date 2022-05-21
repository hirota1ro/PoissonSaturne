import Foundation

struct Point3D {
    let x: Double
    let y: Double
    let z: Double
}

extension Point3D {
    static let zero = Point3D(x: 0, y: 0, z: 0)
}

extension Point3D {

    static func + (a: Point3D, b: Point3D) -> Point3D { return Point3D(x: a.x + b.x, y: a.y + b.y, z:a.z+b.z) }
    static func - (a: Point3D, b: Point3D) -> Point3D { return Point3D(x: a.x - b.x, y: a.y - b.y, z:a.z-b.z) }
    static func * (v: Point3D, s: Double) -> Point3D { return Point3D(x: v.x * s, y: v.y * s, z:v.z*s) }
    static func * (s: Double, v: Point3D) -> Point3D { return Point3D(x: s * v.x, y: s * v.y, z:s*v.z) }
    static func * (a: Point3D, b: Point3D) -> Point3D { return Point3D(x: a.x * b.x, y: a.y * b.y, z:a.z*b.z) }
    static func / (v: Point3D, s: Double) -> Point3D { return Point3D(x: v.x / s, y: v.y / s, z:v.z/s) }
    static func / (s: Double, v: Point3D) -> Point3D { return Point3D(x: s / v.x, y: s / v.y, z:s/v.z) }
    static func / (a: Point3D, b: Point3D) -> Point3D { return Point3D(x: a.x / b.x, y: a.y / b.y, z:a.z/b.z) }
    static prefix func - (p: Point3D) -> Point3D { return Point3D(x: -p.x, y: -p.y, z: -p.z) }

    var quadrance: Double { return x * x + y * y + z * z }
    var norm: Double { return sqrt(quadrance) }
    var normalized: Point3D { return self / norm }
    func dot(_ p: Point3D) -> Double { return x * p.x + y * p.y + z * p.z }
    func distance(to p: Point3D) -> Double { (p - self).norm }
}
