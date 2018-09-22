import XCTest
@testable import UnkoFeelings

class LogCellAnimateModelTests: XCTestCase {

    private var _progress: StubTimeProgress!
    private var _model: LogCellAnimateModel!

    override func setUp() {
        super.setUp()
        _init()
    }
    private func _init() {
        _progress = StubTimeProgress()
        _model = LogCellAnimateModel(progress: _progress)
    }

    func testState() {
        var state: LogCellAnimateModel.State = .notStarted
        XCTAssertTrue(state.enableStart) // true only this
        XCTAssertFalse(state.hasStarted)

        state = .started
        XCTAssertFalse(state.enableStart)
        XCTAssertTrue(state.hasStarted) // true only this
    }

    func testInitialCondition() {
        XCTAssertTrue(_model.state.enableStart)
    }

    func testStateAfterStart() {
        _model.startProgressTimer(startProgressRatio: 0.0)
        XCTAssertFalse(_model.state.enableStart)
        XCTAssertTrue(_model.state.hasStarted)
    }

    func testStart() {
        var info: LogCellAnimateModel.ViewInfo!

        _model.startProgressTimer(startProgressRatio: 0.0)
        info = _model.viewInfo
        XCTAssertTrue(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 0.0)
        XCTAssertEqual(info.durationRest, _model.ANIMATION_DURATION)

        _progress.progressRatio = 0.5
        info = _model.viewInfo
        XCTAssertTrue(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 0.5)
        XCTAssertEqual(info.durationRest, _model.ANIMATION_DURATION * 0.5)

        _progress.progressRatio = 1.0
        info = _model.viewInfo
        XCTAssertFalse(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 1.0)
        XCTAssertEqual(info.durationRest, 0.0)

        _progress.progressRatio = 1.1
        info = _model.viewInfo
        XCTAssertFalse(info.needsAnimate) // false!
        XCTAssertEqual(info.progressedRatio, 1.0)
        XCTAssertEqual(info.durationRest, 0.0)
    }

    func testStartAfterProgressed() {
        _progress.progressRatio = 0.5
        _model.startProgressTimer(startProgressRatio: 0.0)
        let info = _model.viewInfo
        XCTAssertTrue(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 0.5)
        XCTAssertEqual(info.durationRest, _model.ANIMATION_DURATION * 0.5)
    }

    func testStartAfterOverProgressed() {
        _progress.progressRatio = 1.0
        _model.startProgressTimer(startProgressRatio: 0.0)
        var info = _model.viewInfo
        XCTAssertFalse(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 1.0)
        XCTAssertEqual(info.durationRest, 0.0)

        _init()
        _progress.progressRatio = 1.1
        _model.startProgressTimer(startProgressRatio: 0.0)
        info = _model.viewInfo
        XCTAssertFalse(info.needsAnimate)
        XCTAssertEqual(info.progressedRatio, 1.0)
        XCTAssertEqual(info.durationRest, 0.0)
    }

    func testProgressStartArgs() {
        _model.startProgressTimer(startProgressRatio: 0.5)
        XCTAssertEqual(_progress._startedArgs.0, _model.ANIMATION_DURATION)
        XCTAssertEqual(_progress._startedArgs.1, -0.5)
    }
}
