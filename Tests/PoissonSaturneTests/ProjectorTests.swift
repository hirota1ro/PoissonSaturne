import XCTest
@testable import PoissonSaturne

class ProjectorTests: XCTestCase {

    func testProjector() throws {
        let a3 = Affine3D(zRotationAngle: .pi/2)
        let a2 = CGAffineTransform(scaleX: 100, y: 100)
        let projector = Projector(affine3D: a3, affine2D: a2)
        let p = projector.projection(Point3D(x: 1, y: 0, z: 0))
        XCTAssertEqual(p.x, 0, accuracy: 1e-5)
        XCTAssertEqual(p.y, 100, accuracy: 1e-5)
    }
}
