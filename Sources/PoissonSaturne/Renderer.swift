import Foundation
import CoreGraphics

struct Renderer {
    let formula: Formula
    let start: Point3D
    let projector: Projector
    let resolver: ColorResolver
}

extension Renderer {
    static func poisson_saturne(size: CGSize, rotation: Point3D) -> Renderer {
        let form = Formula(X:[0.021, 1.182, -1.183, 0.128, -1.12, -0.641, -1.152, -0.834, -0.97, 0.722],
                           Y:[0.243038, -0.825, -1.2, -0.835443, -0.835443, -0.364557, 0.458, 0.622785,-0.394937, -1.032911],
                           Z:[-0.455696, 0.673, 0.915, -0.258228, -0.495, -0.264, -0.432, -0.416, -0.877,-0.3])
        let start = Point3D(x:0.3, y:-0.06, z:-0.05)
        //
        let s: Double = size.width;
        let scale = Affine3D(scaleX: s, y: s, z:s)
        let tr = Affine3D(translationX: -0.32275423 , y: 0.15, z: 0.04)
        let zr = Affine3D(zRotationAngle: rotation.z * .pi / 180)
        let yr = Affine3D(yRotationAngle: rotation.y * .pi / 180)
        let xr = Affine3D(xRotationAngle: rotation.x * .pi / 180)
        let affine3D: Affine3D = xr * yr * zr * scale * tr
        let affine2D = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
        let proj = Projector(affine3D: affine3D, affine2D: affine2D)
        //
        let color = HSBColorResolver(velocity:Span(min:0.11942243, max:0.9580224),
                                     acceleration: Span(min:0.1779313, max:1.64469))

        return Renderer(formula: form, start: start, projector: proj, resolver: color)
    }

    static func solar_sail(size: CGSize, rotation: Point3D) -> Renderer {
        let form = Formula(X:[0.744304, -0.546835, 0.121519, -0.653165, 0.399, 0.379, 0.44, 1.014, -0.805063, 0.377],
                           Y:[-0.683, 0.531646, -0.04557, -1.2, -0.546835, 0.091139, 0.744304, -0.273418, -0.349367, -0.531646],
                           Z:[0.712, 0.744304, -0.577215, 0.966, 0.04557, 1.063291, 0.01519, -0.425316, 0.212658, -0.01519])
        let start = Point3D(x:0.28186548, y:-0.3421066, z:0.4735889)
        //
        let s: Double = size.width;
        let scale = Affine3D(scaleX: s, y: s, z:s)
        let tr = Affine3D(translationX: -0.28186548, y: 0.3421066, z: -0.4735889)
        let zr = Affine3D(zRotationAngle: rotation.z * .pi / 180)
        let yr = Affine3D(yRotationAngle: rotation.y * .pi / 180)
        let xr = Affine3D(xRotationAngle: rotation.x * .pi / 180)
        let affine3D: Affine3D = xr * yr * zr * scale * tr
        let affine2D = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
        let proj = Projector(affine3D: affine3D, affine2D: affine2D)
        //
        let color = HSBColorResolver(velocity:Span(min:0.012535486, max:1.2682475),
                                     acceleration: Span(min:0.015339427, max:2.2831714))

        return Renderer(formula: form, start: start, projector: proj, resolver: color)
    }
}

extension Renderer {
    func render(n: Int) {
        var p = start
        var velocity: Point3D = .zero
        for i in 0 ..< n {
            let prev: Point3D = p
            p = formula.transform(point: p)
            let u: Point3D = velocity
            velocity = p - prev
            if i > 20 {
                resolver.resolve(velocity: velocity, acceleration: velocity - u).setFill()
                CGRect(origin:projector.projection(p), size:CGSize(width:1, height:1)).fill()
            }
        }
    }
}
