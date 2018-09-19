import Foundation

//TODO: Make tests
class LogCellModel {
    private var _feeling: Feeling

    init(feeling: Feeling) {
        _feeling = feeling
    }

    var message: String {
        return _feeling.message
    }
}
