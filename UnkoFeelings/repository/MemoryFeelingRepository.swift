import Foundation

class MemoryFeelingRepository: FeelingRepository {
    private var _feelings: [Feeling] = []

    func insertMockData() -> MemoryFeelingRepository {
        _feelings.append(Feeling(message: "HelloUnko1", condition: .normal, postedAt: Date(timeIntervalSinceNow: -3)))
        _feelings.append(Feeling(message: "HelloUnko2", condition: .normal, postedAt: Date(timeIntervalSinceNow: -2)))
        _feelings.append(Feeling(message: "HelloUnko3\nThis\nIs\n3", condition: .normal, postedAt: Date(timeIntervalSinceNow: -1)))
        _feelings.append(Feeling(message: "HelloUnko4", condition: .normal, postedAt: Date(timeIntervalSinceNow:  0)))
        return self
    }

    func fetchFeelings() -> [Feeling] {
        return _feelings
    }
    func updateFeelings(feelings: [Feeling]) {
        _feelings = feelings
    }
}
