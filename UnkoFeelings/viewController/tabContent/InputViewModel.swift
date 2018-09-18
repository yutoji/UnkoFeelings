import Foundation
import UIKit

class InputViewModel {
    weak var delegate: InputViewModelDelegate?
    private var _timeline: FeelingTimelineUpdatable

    var text: String {
        didSet {
            delegate?.onInputViewModelUpdated()
        }
    }
    var isSubmittable: Bool {
        return text.count > 0
    }

    init(timeline: FeelingTimelineUpdatable) {
        _timeline = timeline
        text = ""
    }

    func submit() {
        let condition = FeelingCondition.normal
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
