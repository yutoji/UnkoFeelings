//

import XCTest
@testable import UnkoFeelings

class InputViewModelTests: XCTestCase {

    private var _timeline: (FeelingTimeline & FeelingTimelineUpdatable)!
    private var _viewModel: InputViewModel!
    private var _delegate: _InputViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        let entityCreator = FeelingEntityCreator(uniqueIDGenerator: StubUniqueIDGenerator())
        _timeline = FeelingTimelineImpl(repository: MemoryFeelingRepository(entityCreator), entityCreator: entityCreator)
        _viewModel = InputViewModel(timeline: _timeline)
        _delegate = _InputViewModelDelegate()
        _viewModel.delegate = _delegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(_viewModel.text, "")
        XCTAssertFalse(_viewModel.isSubmittable)
        XCTAssertEqual(_delegate.updateCalledCount, 0)
        XCTAssertEqual(_timeline.feelings.count, 0)
    }

    func testSubmittableFlag() {
        _viewModel.text = "a"
        XCTAssertTrue(_viewModel.isSubmittable)
        _viewModel.text = ""
        XCTAssertFalse(_viewModel.isSubmittable)

        XCTAssertEqual(_timeline.feelings.count, 0)
    }

    func testSetText() {
        _viewModel.text = "hello"
        XCTAssertEqual(_viewModel.text, "hello")
        _viewModel.text = "nop"
        XCTAssertEqual(_viewModel.text, "nop")

        XCTAssertEqual(_timeline.feelings.count, 0)
    }

    func testUpdatedDelegateCalledCountAfterSettingText() {
        XCTAssertEqual(_delegate.updateCalledCount, 0)
        _viewModel.text = "hello"
        XCTAssertEqual(_delegate.updateCalledCount, 1)
        _viewModel.text = "no"
        _viewModel.text = "yes"
        XCTAssertEqual(_delegate.updateCalledCount, 3)
        _viewModel.text = ""
        XCTAssertEqual(_delegate.updateCalledCount, 4)

        XCTAssertEqual(_timeline.feelings.count, 0)
    }

    func testClearText() {
        XCTAssertEqual(_delegate.updateCalledCount, 0)
        _viewModel.text = "hello"
        XCTAssertEqual(_delegate.updateCalledCount, 1)
        _viewModel.clearText()
        XCTAssertEqual(_delegate.updateCalledCount, 2)
        XCTAssertEqual(_viewModel.text, "")

        XCTAssertEqual(_timeline.feelings.count, 0)
    }

    func testSubmit() {
        _viewModel.text = "Hello, World."
        XCTAssertEqual(_delegate.updateCalledCount, 1)
        XCTAssertTrue(_viewModel.isSubmittable)
        XCTAssertEqual(_timeline.feelings.count, 0)
        _viewModel.submit()
        XCTAssertEqual(_timeline.feelings.count, 1)
        XCTAssertEqual(_timeline.feelings[0].message, "Hello, World.")

        // after submit, the text value must be cleared.
        XCTAssertEqual(_viewModel.text, "")
        XCTAssertEqual(_delegate.updateCalledCount, 2)
    }

}

fileprivate class _InputViewModelDelegate: InputViewModelDelegate {
    var updateCalledCount: Int = 0 // value for test

    func onInputViewModelUpdated() {
        updateCalledCount += 1
    }
}
