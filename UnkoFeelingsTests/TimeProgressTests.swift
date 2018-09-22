import XCTest
@testable import UnkoFeelings

class TimeProgressTests: XCTestCase {

    private let _dateMaker: StubDateMaker = StubDateMaker()
    private let _now: Date = Date(timeIntervalSinceReferenceDate: 0)
    private var progress: TimeProgress!

    override func setUp() {
        super.setUp()
        _dateMaker.stub = _now
    }

    private func nearlyEquals(_ lhs: Double, _ rhs: Double) -> Bool {
        return abs(lhs - rhs) <= 0.00000001
    }

    func testHasStarted() {
        progress = TimeProgress(startWithCompleteDuration: 3.0, startOffset: 0, dateMaker: _dateMaker)
        XCTAssertTrue(progress.hasStarted)

        progress = TimeProgress(dateMaker: _dateMaker)
        XCTAssertFalse(progress.hasStarted)
        progress.start(completeDuration: 3.0, startOffset: 0)
        XCTAssertTrue(progress.hasStarted)
    }

    func testProgressRatio() {
        _dateMaker.stub = _now

        progress = TimeProgress(startWithCompleteDuration: 3.0, startOffset: 0, dateMaker: _dateMaker)
        XCTAssertEqual(progress.progressRatio, 0.0)
        XCTAssertFalse(progress.isCompleted)

        XCTAssertFalse(nearlyEquals(0.00721, 0.00722))

        _dateMaker.stub = _now.addingTimeInterval(0.3)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.1))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(2.7)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.9))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(3.00001)
        XCTAssertEqual(progress.progressRatio, 1.0)
        XCTAssertTrue(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(3.1)
        XCTAssertEqual(progress.progressRatio, 1.0)
        XCTAssertTrue(progress.isCompleted)
    }

    func testStartOffset() {
        _dateMaker.stub = _now
        progress = TimeProgress(startWithCompleteDuration: 10.0, startOffset: -1.0, dateMaker: _dateMaker)

        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.1))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(2.0)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.3))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(8.99)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.999))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(9.01)
        XCTAssertEqual(progress.progressRatio, 1.0)
        XCTAssertTrue(progress.isCompleted)
    }

    func testFowardStartOffset() {
        _dateMaker.stub = _now

        progress = TimeProgress(startWithCompleteDuration: 1.0, startOffset: +10.0, dateMaker: _dateMaker)
        XCTAssertEqual(progress.progressRatio, 0.0)
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(11.1)
        XCTAssertEqual(progress.progressRatio, 1.0)
        XCTAssertTrue(progress.isCompleted)
    }

    func testWithDelayStart() {
        _dateMaker.stub = _now
        progress = TimeProgress(dateMaker: _dateMaker)
        progress.start(completeDuration: 10.0, startOffset: -1.0) // POINT!!

        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.1))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(2.0)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.3))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(8.99)
        XCTAssertTrue(nearlyEquals(progress.progressRatio, 0.999))
        XCTAssertFalse(progress.isCompleted)

        _dateMaker.stub = _now.addingTimeInterval(9.01)
        XCTAssertEqual(progress.progressRatio, 1.0)
        XCTAssertTrue(progress.isCompleted)
    }

}
