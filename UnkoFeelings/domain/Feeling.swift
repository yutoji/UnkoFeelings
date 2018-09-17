import Foundation

struct Feeling {
    var message: String
    var condition: FeelingCondition
    var postedAt: Date
}

extension Feeling : Equatable {
    static func == (lhs: Feeling, rhs: Feeling) -> Bool {
        return lhs.postedAt == rhs.postedAt &&
            lhs.message == rhs.message &&
            lhs.condition == rhs.condition;
    }
}
