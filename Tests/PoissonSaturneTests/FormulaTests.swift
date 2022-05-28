import XCTest
@testable import PoissonSaturne

class FormulaTests: XCTestCase {

    func testFormula() throws {
        let formula = Formula(X:[0.021, 1.182, -1.183, 0.128, -1.12, -0.641, -1.152, -0.834, -0.97, 0.722],
                              Y:[0.243038, -0.825, -1.2, -0.835443, -0.835443, -0.364557, 0.458, 0.622785,-0.394937, -1.032911],
                              Z:[-0.455696, 0.673, 0.915, -0.258228, -0.495, -0.264, -0.432, -0.416, -0.877,-0.3])

        let start = Point3D(x:0.3, y:-0.06, z:-0.05)
        let p = formula.transform(point: start)
        XCTAssertEqual(p.x, 0.36574179999999995, accuracy: 1e-5)
        XCTAssertEqual(p.y, -0.04233723349999995, accuracy: 1e-5)
        XCTAssertEqual(p.z, -0.10323609600000003, accuracy: 1e-5)
    }
}
