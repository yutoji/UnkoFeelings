protocol FeelingRepository {
    func fetchFeelings() -> [Feeling]
    func updateFeelings(feelings: [Feeling])
}
