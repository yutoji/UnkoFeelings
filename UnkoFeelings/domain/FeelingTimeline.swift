protocol FeelingTimeline {
    var delegate: FeelingTimelineDelegate? { get set }
    var entities: [FeelingEntity] { get }   // Entities
    var feelings: [Feeling] { get }         // Value objects
}

protocol FeelingTimelineDelegate : class {
    func onFeelingTimelineUpdated()
}

protocol FeelingTimelineUpdatable {
    func addFeeling(feeling: Feeling)
    func removeFeeling(entity: FeelingEntity)
}

class FeelingTimelineImpl: FeelingTimeline, FeelingTimelineUpdatable {
    weak var delegate: FeelingTimelineDelegate?
    private var _repository: FeelingRepository
    private var _entities: [FeelingEntity]
    private var _creator: FeelingEntityCreatable

    init(repository: FeelingRepository, entityCreator: FeelingEntityCreatable) {
        _repository = repository
        _creator = entityCreator
        _entities = repository.fetchEntities()
        _sortByPostedAt()
    }

    var entities: [FeelingEntity] {
        return _entities
    }
    var feelings: [Feeling] {
        return _entities.map({$0.feeling})
    }

    func addFeeling(feeling: Feeling) {
        let entity = _creator.create(feeling: feeling)
        _entities.insert(entity, at: 0)
        _sortByPostedAt()
        _updateRepositoryWithCallingDelegate()
    }

    func removeFeeling(entity: FeelingEntity) {
        guard let targetIndex = _entities.index(where: {$0.id == entity.id}) else {
            assert(false, "targetIndex not exists.\(entity)")
            return
        }
        _entities.remove(at: targetIndex)
        _updateRepositoryWithCallingDelegate()
    }

    private func _updateRepositoryWithCallingDelegate() {
        _repository.update(entities: _entities)
        delegate?.onFeelingTimelineUpdated()
    }

    private func _sortByPostedAt() {
        _entities.sort(by: {$0.feeling.postedAt > $1.feeling.postedAt})
    }
}
