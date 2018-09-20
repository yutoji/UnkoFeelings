import XCTest
@testable import UnkoFeelings

class LogCellModelFactoryTests: XCTestCase {

    private var _factory: LogCellModelFactory!
    private var _sampleEntities: [FeelingEntity] = [
        FeelingEntityImpl(id: "1", feeling: Feeling(message: "unko0", condition: .normal, postedAt: Date())),
        FeelingEntityImpl(id: "2", feeling: Feeling(message: "unko1", condition: .hard, postedAt: Date(timeIntervalSinceNow: -60*60*24*1))),
        FeelingEntityImpl(id: "3", feeling: Feeling(message: "unko2", condition: .soft, postedAt: Date(timeIntervalSinceNow: -60*60*24*2))),
        ]

    override func setUp() {
        super.setUp()
        _factory = LogCellModelFactory()
    }

    func testGetOrCreate() {
        let firstLeft  = _factory.getOrCreate(entity: _sampleEntities[0])
        let firstRight = _factory.getOrCreate(entity: _sampleEntities[0])
        XCTAssertTrue(firstLeft === firstRight)

        let secondLeft  = _factory.getOrCreate(entity: _sampleEntities[1])
        let secondRight = _factory.getOrCreate(entity: _sampleEntities[1])
        XCTAssertTrue(secondLeft === secondRight)

        let firstTop  = _factory.getOrCreate(entity: _sampleEntities[0])
        let secondTop = _factory.getOrCreate(entity: _sampleEntities[1])
        XCTAssertTrue(firstTop === firstRight)
        XCTAssertTrue(secondTop === secondRight)

        // check the content
        XCTAssertEqual(firstLeft.message,  "unko0")
        XCTAssertEqual(secondLeft.message, "unko1")
    }

}
