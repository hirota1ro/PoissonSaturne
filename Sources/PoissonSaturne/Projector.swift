import Foundation
import CoreGraphics

struct Projector {
    let affine3D: Affine3D
    let affine2D: CGAffineTransform
}

extension Projector {
    func projection(_ p: Point3D) -> CGPoint {
        let q: Point3D = affine3D * p
        return CGPoint(x: q.x, y: q.y).applying(affine2D)
    }
}
