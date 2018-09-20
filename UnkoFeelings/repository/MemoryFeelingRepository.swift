import Foundation

class MemoryFeelingRepository: FeelingRepository {
    private var _entities: [FeelingEntity] = []
    private var _creator: FeelingEntityCreatable

    init(_ entityCreator: FeelingEntityCreatable) {
        _creator = entityCreator
    }

    func insertMockData() -> MemoryFeelingRepository {
        _entities.append(_creator.create(feeling: Feeling(message: "HelloUnko1", condition: .normal, postedAt: Date(timeIntervalSinceNow: -3))))
        _entities.append(_creator.create(feeling: Feeling(message: "HelloUnko2", condition: .normal, postedAt: Date(timeIntervalSinceNow: -2))))
        _entities.append(_creator.create(feeling: Feeling(message: "HelloUnko3\nThis\nIs\n3", condition: .normal, postedAt: Date(timeIntervalSinceNow: -1))))
        _entities.append(_creator.create(feeling: Feeling(message: "HelloUnko4", condition: .normal, postedAt: Date(timeIntervalSinceNow:  0))))
        return self
    }

    func fetchEntities() -> [FeelingEntity] {
        return _entities
    }
    func update(entities: [FeelingEntity]) {
        _entities = entities
    }
}
