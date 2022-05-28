import XCTest
@testable import PoissonSaturne

class Affine3DTests: XCTestCase {

    func testAffine3D() throws {
        let zr = Affine3D(zRotationAngle: .pi/2)
        let p = Point3D(x: 1, y: 0, z: 0)
        let p2 = zr * p
        XCTAssertEqual(p2.x, 0, accuracy: 1e-5)
        XCTAssertEqual(p2.y, 1, accuracy: 1e-5)
        XCTAssertEqual(p2.z, 0, accuracy: 1e-5)
    }
}
