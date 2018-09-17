//

import XCTest
@testable import UnkoFeelings

class FeelingTests: XCTestCase {

    private var _now: Date!
    private var _feeling: Feeling!
    
    override func setUp() {
        super.setUp()
        _now = Date()
        _feeling = FeelingImpl(message: "It's Good!", condition: .normal, postedAt: _now)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProperties() {
        XCTAssertEqual(_feeling.message, "It's Good!")
        XCTAssertEqual(_feeling.condition, .normal)
        XCTAssertEqual(_feeling.postedAt, _now)
    }

    func testConditionImages() {
        func imageExists(condition: FeelingCondition) -> Bool {
            let image = UIImage(named: condition.imageFileName)
            return image != nil
        }
        for condition in FeelingCondition.cases {
            XCTAssertTrue(imageExists(condition: condition), String(describing: condition) )
        }
    }

}
