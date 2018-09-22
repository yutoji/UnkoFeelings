import Foundation
import UIKit

class InputViewModel {
    weak var delegate: InputViewModelDelegate?
    private var _timeline: FeelingTimelineUpdatable
    public var pickableConditions: [FeelingCondition] = [.soft, .normal, .hard]

    var text: String {
        didSet {
            delegate?.onInputViewModelUpdated()
        }
    }
    var isSubmittable: Bool {
        return text.count > 0
    }

    var condition: FeelingCondition {
        didSet {
            delegate?.onInputViewModelUpdated()
        }
    }

    var conditionIndex: Int {
        return pickableConditions.index(of: condition)!
    }

    init(timeline: FeelingTimelineUpdatable) {
        _timeline = timeline
        text = ""
        condition = .normal
    }

    func submit() {
        assert(isSubmittable, "Unable to submit due to blank text.")
        _timeline.addFeeling(feeling:
            Feeling(message: text, condition: condition, postedAt: Date())
        )
        clearText()
    }

    func clearText() {
        text = ""
    }
}

protocol InputViewModelDelegate : class {
    func onInputViewModelUpdated()
}
