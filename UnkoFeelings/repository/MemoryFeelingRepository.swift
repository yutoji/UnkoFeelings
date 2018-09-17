import Foundation

class MemoryFeelingRepository: FeelingRepository {
    private var _feelings: [Feeling] = []

    func fetchFeelings() -> [Feeling] {
        return _feelings
    }
    func updateFeelings(feelings: [Feeling]) {
        _feelings = feelings
    }
}
