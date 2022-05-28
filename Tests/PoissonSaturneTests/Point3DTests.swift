import XCTest
@testable import PoissonSaturne

class Point3DTests: XCTestCase {

    func testPoint3D() throws {
        let p1 = Point3D(x: 1, y: 0, z: 0)
        let p2 = Point3D(x: 0, y: 1, z: 0)
        let p3 = p1 + p2
        XCTAssertEqual(p3.x, 1, accuracy: 1e-5)
        XCTAssertEqual(p3.y, 1, accuracy: 1e-5)
        XCTAssertEqual(p3.z, 0, accuracy: 1e-5)
    }
}
