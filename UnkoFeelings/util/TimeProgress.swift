import Foundation

protocol TimeProgressProtocol {
    var hasStarted: Bool { get }
    func start(completeDuration: TimeInterval, startOffset: TimeInterval)
    // Outputs of this class
    var isCompleted: Bool { get }
    var progressRatio: Double { get }
}

class TimeProgress: TimeProgressProtocol {
    private var _completeDuration: TimeInterval!
    private var _startOffset: TimeInterval!
    private var _startedAt: Date!
    private let _dateMaker: DateMakable

    /// After call this initializer, progression will be started automatically
    init(startWithCompleteDuration completeDuration: TimeInterval, startOffset: TimeInterval, dateMaker: DateMakable) {
        _dateMaker = dateMaker
        self.start(completeDuration: completeDuration, startOffset: startOffset)
    }

    /// After call this initializer,
    /// Shall set .completeDuration & .startOffset and call .start()
    init(dateMaker: DateMakable) {
        _dateMaker = dateMaker
    }

    public var hasStarted: Bool {
        return _startedAt != nil
    }

    func start(completeDuration: TimeInterval, startOffset: TimeInterval) {
        assert(!hasStarted)
        self._completeDuration = completeDuration
        self._startOffset = startOffset
        _startedAt = _dateMaker.make().addingTimeInterval(startOffset)
    }

    var isCompleted: Bool {
        assert(hasStarted)
        return progressRatio >= 1.0
    }

    var progressRatio: Double {
        assert(hasStarted)
        let elapsed = _dateMaker.make().timeIntervalSinceReferenceDate - _startedAt.timeIntervalSinceReferenceDate
        var ratio: Double = elapsed / _completeDuration
        ratio = min(ratio, 1.0)
        ratio = max(ratio, 0.0)
        return ratio
    }
}
