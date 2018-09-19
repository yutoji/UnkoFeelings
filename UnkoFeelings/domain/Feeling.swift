import Foundation

// This is 'value-object' to get view-layer enable to communicate with domain.
// For 'entity' purpose, use FeelingEntity instead.
//TODO: Implement FeelingEntity class as an entity.

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
