import Foundation
import UIKit

/// Protocol for LogCell class.
protocol LogCellAnimateModelProtocol: class {
    var viewInfo: LogCellAnimateModel.ViewInfo { get }
}

class LogCellAnimateModel: LogCellAnimateModelProtocol {
    let ANIMATION_DURATION: TimeInterval = 1.0

    private var _progress: TimeProgressProtocol
    private var _state: State

    init(progress: TimeProgressProtocol) {
        assert(!progress.hasStarted)
        _progress = progress
        _state = .notStarted
    }

    enum State {
        case notStarted
        case started
        var enableStart: Bool { return self == .notStarted }
        var hasStarted:  Bool { return self == .started }
    }

    var state: State {
        return _state
    }

    func startProgressTimer(startProgressRatio: Double) {
        assert(state.enableStart)
        let startTimeOffset = -(startProgressRatio * ANIMATION_DURATION)
        _progress.start(completeDuration: ANIMATION_DURATION, startOffset: startTimeOffset)
        _state = .started
    }

    var viewInfo: ViewInfo {
        assert(state.hasStarted)

        let durationRest = _progress.isCompleted ?
            0.0 :
            (1.0 - _progress.progressRatio) * ANIMATION_DURATION

        return ViewInfo(
            needsAnimate: !_progress.isCompleted,
            progressedRatio: CGFloat(_progress.progressRatio),
            durationRest: TimeInterval(durationRest)
        )
    }

    struct ViewInfo: Equatable {
        var needsAnimate: Bool
        var progressedRatio: CGFloat // 0.0 ~ 1.0
        var durationRest: TimeInterval // 0.0 ~ ANIMATION_DURATION
        // computed
        var iconAlpha: CGFloat { // First-More-Transparent
            return progressedRatio
        }
        var iconPositionDiffRatio: CGFloat { // First-Far-Position
            return 1.0 - progressedRatio
        }
    }
}
