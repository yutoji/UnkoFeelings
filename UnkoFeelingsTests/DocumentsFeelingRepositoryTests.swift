import XCTest
@testable import UnkoFeelings

class DocumentsFeelingRepositoryTests: XCTestCase {

    private var _repository: DocumentsFeelingRepository!
    private let _stubFilepath = URL(string: "feeling_entities_for_tests.json", relativeTo: FileManager.default.temporaryDirectory)!

    private var _sampleEntities: [FeelingEntity] = [
        FeelingEntityImpl(id: "1", feeling: Feeling(message: "unko0", condition: .normal, postedAt: Date())),
        FeelingEntityImpl(id: "2", feeling: Feeling(message: "unko1", condition: .hard, postedAt: Date(timeIntervalSinceNow: -60*60*24*1))),
        FeelingEntityImpl(id: "3", feeling: Feeling(message: "unko2", condition: .soft, postedAt: Date(timeIntervalSinceNow: -60*60*24*2))),
        ]

    override func setUp() {
        super.setUp()
        _cleanupStubFile()
        _setupRepository()
    }

    private func _cleanupStubFile() {
        let manager = FileManager.default
        if manager.fileExists(atPath: _stubFilepath.path) {
            try! manager.removeItem(at: _stubFilepath)
        }
    }

    private func _setupRepository() {
        _repository = DocumentsFeelingRepository(filepathToSave: _stubFilepath)
    }

    override func tearDown() {
        super.tearDown()
        _cleanupStubFile()
    }

    func testBlank() {
        XCTAssertEqual(_repository.fetchEntities().count, 0)

        _repository.update(entities: [])
        XCTAssertEqual(_repository.fetchEntities().count, 0)

        _cleanupStubFile()
        XCTAssertEqual(_repository.fetchEntities().count, 0)
    }

    func _samples(_ range: CountableClosedRange<Int>) -> [FeelingEntity] {
        return [FeelingEntity](_sampleEntities[range])
    }
    func _sample(_ i: Int) -> FeelingEntity {
        return _sampleEntities[i]
    }

    func testUpdate() {
        var entities: [FeelingEntity]!

        _repository.update(entities: _samples(0...0))
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 1)
        XCTAssert(entities[0].contentEquals(_sample(0)))

        _repository.update(entities: [])
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 0)

        _repository.update(entities: _samples(0...1))
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 2)
        XCTAssert(entities[0].contentEquals(_sample(0)))
        XCTAssert(entities[1].contentEquals(_sample(1)))

        // same order to update arg (sorting-by-.postedAt is domain's job)
        _repository.update(entities: _samples(0...1).reversed())
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 2)
        XCTAssert(entities[0].contentEquals(_sample(1))) // index reversed
        XCTAssert(entities[1].contentEquals(_sample(0)))

        _repository.update(entities: [])
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 0)
    }

    func testBlankAfterFiledelete() {
        var entities: [FeelingEntity]!

        _repository.update(entities: _samples(0...1))
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 2)

        _cleanupStubFile()
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 0)
    }

    func testContentAfterReinitializeInstance() {
        var entities: [FeelingEntity]!

        _repository.update(entities: _samples(0...2))
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 3)

        _setupRepository() // reset object!
        entities = _repository.fetchEntities()
        XCTAssertEqual(entities.count, 3)
        XCTAssert(entities[1].contentEquals(_sample(1)))
    }

}
