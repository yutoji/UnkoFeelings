//

import XCTest
@testable import UnkoFeelings

class FeelingTimelineTests: XCTestCase {

    private var _repository: FeelingRepository!
    private var _timeline: (FeelingTimeline & FeelingTimelineUpdatable)!
    private var _sampleFeelings: [Feeling] = [
        Feeling(message: "unko0", condition: .normal, postedAt: Date()),
        Feeling(message: "unko1", condition: .hard, postedAt: Date(timeIntervalSinceNow: -60*60*24*1)),
        Feeling(message: "unko2", condition: .soft, postedAt: Date(timeIntervalSinceNow: -60*60*24*2)),
    ]

    private func _sampleFeelingsByIndices(_ indices: [Int]) -> [Feeling] {
        return indices.map{_sampleFeelings[$0]}
    }

    override func setUp() {
        super.setUp()
        _setupTimeline()
    }

    private func _setupTimeline(withDefaultFeelings feelings: [Feeling] = []) {
        _repository = MemoryFeelingRepository()
        _repository.updateFeelings(feelings: feelings)
        _timeline = FeelingTimelineImpl(repository: _repository)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialFeelingsState() {
        _setupTimeline(withDefaultFeelings: [])
        XCTAssertEqual(_timeline.feelings, [Feeling]())

        _setupTimeline(withDefaultFeelings: _sampleFeelings)
        XCTAssertEqual(_timeline.feelings, _sampleFeelings)

        // Sorted output by reversed input
        _setupTimeline(withDefaultFeelings: _sampleFeelings.reversed())
        XCTAssertEqual(_timeline.feelings, _sampleFeelings)
    }

    func testAdd() {
        _setupTimeline(withDefaultFeelings: [])

        _timeline.addFeeling(feeling: _sampleFeelings[0])
        XCTAssertEqual(_timeline.feelings, _sampleFeelingsByIndices([0]))

        _timeline.addFeeling(feeling: _sampleFeelings[1])
        XCTAssertEqual(_timeline.feelings, _sampleFeelingsByIndices([0, 1]))

        _timeline.addFeeling(feeling: _sampleFeelings[2])
        XCTAssertEqual(_timeline.feelings, _sampleFeelings)
    }

    func testSortAfterReverseAdding() {
        _timeline.addFeeling(feeling: _sampleFeelings[2])
        _timeline.addFeeling(feeling: _sampleFeelings[1])
        XCTAssertEqual(_timeline.feelings, _sampleFeelingsByIndices([1,2]))

        _timeline.addFeeling(feeling: _sampleFeelings[0])
        XCTAssertEqual(_timeline.feelings, _sampleFeelings)
    }

    func testRemove() {
        _setupTimeline(withDefaultFeelings: _sampleFeelings)
        _timeline.removeFeeling(feeling: _sampleFeelings[1])
        XCTAssertEqual(_timeline.feelings, _sampleFeelingsByIndices([0,2]))

        _timeline.removeFeeling(feeling: _sampleFeelings[0])
        XCTAssertEqual(_timeline.feelings, _sampleFeelingsByIndices([2]))

        _timeline.removeFeeling(feeling: _sampleFeelings[2])
        XCTAssertEqual(_timeline.feelings, [Feeling]())
    }

    //TODO: The 'remove' test in case not element found error is needed.
}
