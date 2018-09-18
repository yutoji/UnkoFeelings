protocol FeelingTimeline {
    var delegate: FeelingTimelineDelegate? { get set }
    var feelings: [Feeling] { get }
}

protocol FeelingTimelineDelegate : class {
    func onFeelingTimelineUpdated()
}

protocol FeelingTimelineUpdatable {
    func addFeeling(feeling: Feeling)
    func removeFeeling(feeling: Feeling)
}

class FeelingTimelineImpl: FeelingTimeline, FeelingTimelineUpdatable {
    weak var delegate: FeelingTimelineDelegate?
    private var _repository: FeelingRepository
    private var _feelings: [Feeling]

    init(repository: FeelingRepository) {
        _repository = repository
        _feelings = repository.fetchFeelings()
        _sortByPostedAt()
    }

    var feelings: [Feeling] {
        return _feelings
    }

    func addFeeling(feeling: Feeling) {
        _feelings.insert(feeling, at: 0)
        _sortByPostedAt()
        _updateRepositoryWithCallingDelegate()
    }

    func removeFeeling(feeling: Feeling) {
        guard let targetIndex = _feelings.index(where: { (eachFeeling) in
            return eachFeeling.postedAt == feeling.postedAt
        }) else {
            assert(false, "targetIndex not exists.\(feeling)")
            return
        }
        _feelings.remove(at: targetIndex)
        _updateRepositoryWithCallingDelegate()
    }

    private func _updateRepositoryWithCallingDelegate() {
        _repository.updateFeelings(feelings: _feelings)
        delegate?.onFeelingTimelineUpdated()
    }

    private func _sortByPostedAt() {
        _feelings.sort(by: {$0.postedAt > $1.postedAt})
    }
}
