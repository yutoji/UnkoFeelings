//

import XCTest
@testable import UnkoFeelings

class LogViewControllerAnimateModelTests: XCTestCase {
    
    func testOffsetRatio() {
        let model = LogViewControllerAnimateOffsetIterator(numAnimateCell: 5)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.0)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.2)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.4)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.6)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.8)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 1.0)
        XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 1.0)

        let waitInterval = 0.1
        let resetExpectation = expectation(description: "reset")
        DispatchQueue.main.asyncAfter(deadline: .now() + LogViewControllerAnimateOffsetIterator.RESET_DELAY) {
            XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.0)
            XCTAssertEqual(model.publishNextAnimateOffsetRatio(), 0.2)
            resetExpectation.fulfill()
        }
        waitForExpectations(timeout: waitInterval * 2, handler: nil)
    }
    
}
