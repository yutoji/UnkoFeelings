import Foundation

class MemoryFeelingRepository: FeelingRepository {
    private var _feelings: [Feeling]

    func init(feelings: [Feelings]) {
        _feelings = feelings
    }
    
    func fetchFeelings() -> [Feeling] {
        return _feelings
    }
    func updateFeelings(feelings: [Feeling]) {
        _feelings = feelings
    }
}
