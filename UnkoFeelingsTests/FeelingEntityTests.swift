//

import XCTest
@testable import UnkoFeelings

class FeelingEntityTests: XCTestCase {

    private var _idGenerator: StubUniqueIDGenerator!
    private var _entityCreator: FeelingEntityCreatable!

    private var _sampleFeeling: Feeling = Feeling(message: "unko0", condition: .normal, postedAt: Date())

    override func setUp() {
        super.setUp()
        _idGenerator = StubUniqueIDGenerator()
        _entityCreator = FeelingEntityCreator(uniqueIDGenerator: _idGenerator)
    }
    
    func testFeelingEntityCreatedIDs() {
        XCTAssertEqual(_idGenerator.createdCount, 0)

        var entity: FeelingEntity!

        entity = _entityCreator.create(feeling: _sampleFeeling)
        XCTAssertEqual(entity.id, "1")
        XCTAssertEqual(_idGenerator.createdCount, 1)
        XCTAssertEqual(entity.feeling, _sampleFeeling)

        entity = _entityCreator.create(feeling: _sampleFeeling)
        XCTAssertEqual(entity.id, "2")
        XCTAssertEqual(_idGenerator.createdCount, 2)
        XCTAssertEqual(entity.feeling, _sampleFeeling)
    }

}
