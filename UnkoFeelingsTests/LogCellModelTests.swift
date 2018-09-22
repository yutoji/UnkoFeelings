import XCTest
@testable import UnkoFeelings

class LogCellModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testConditionImageExistence() {
        let maker = LogCellModelConditionImageMaker()
        XCTAssertNotNil( maker.make(condition: .normal) )
        XCTAssertNotNil( maker.make(condition: .hard) )
        XCTAssertNotNil( maker.make(condition: .soft) )
    }
}
