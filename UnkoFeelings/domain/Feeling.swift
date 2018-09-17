import Foundation

protocol Feeling {
    var message: String { get }
    var condition: FeelingCondition { get }
    var postedAt: Date { get }
}

struct FeelingImpl: Feeling {
    var message: String
    var condition: FeelingCondition
    var postedAt: Date
}
