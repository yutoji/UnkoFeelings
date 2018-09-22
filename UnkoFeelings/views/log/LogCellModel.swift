import Foundation
import UIKit

//TODO: Make tests
class LogCellModel {
    private var _feeling: Feeling
    private var _conditionImages = [FeelingCondition:UIImage]()

    init(feeling: Feeling) {
        _feeling = feeling
    }

    var message: String {
        return _feeling.message
    }

    var conditionImage: UIImage {
        let condition = _feeling.condition
        if _conditionImages[condition] == nil {
            let maker = LogCellModelConditionImageMaker()
            guard let image = maker.make(condition: condition) else {
                assertionFailure("couldn't make image. \(condition)")
                return UIImage()
            }
            _conditionImages[condition] = image
        }
        return _conditionImages[condition]!
    }
}

class LogCellModelConditionImageMaker {
    func make(condition: FeelingCondition) -> UIImage? {
        let filename = condition.imageFileName
        guard let image = UIImage(named: filename) else {
            return nil
        }
        return image
    }
}
