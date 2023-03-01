import Foundation
import CoreGraphics

struct Renderer {
    let formula: Formula
    let start: Point3D
    let projector: Projector
    let resolver: ColorResolver
}

extension Renderer {

    func render(n: Int) {
        var p = start
        var velocity: Point3D = .zero
        for i in 0 ..< n {
            let prev: Point3D = p
            p = formula(p)
            let u: Point3D = velocity
            velocity = p - prev
            if i > 20 {
                resolver.resolve(velocity: velocity, acceleration: velocity - u).setFill()
                CGRect(origin: projector.projection(p), size: CGSize(width: 1, height: 1)).fill()
            }
        }
    }
}
