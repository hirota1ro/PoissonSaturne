import XCTest
@testable import PoissonSaturne

class SpanTests: XCTestCase {

    func testSpan() throws {
        var span = Span()
        span.update(0.1)
        span.update(0.9)
        XCTAssertEqual(span.value, 0.8, accuracy: 1e-5)
        XCTAssertEqual(span.center, 0.5, accuracy: 1e-5)
        XCTAssertEqual(span.normalized(0.5), 0.5, accuracy: 1e-5)
    }
}
