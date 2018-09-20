import Foundation

class MemoryFeelingRepository: FeelingRepository {
    private var _entities: [FeelingEntity] = []

    func insertMockData() -> MemoryFeelingRepository {
        _entities.append(FeelingEntityImpl(id: 1, feeling: Feeling(message: "HelloUnko1", condition: .normal, postedAt: Date(timeIntervalSinceNow: -3))))
        _entities.append(FeelingEntityImpl(id: 2, feeling: Feeling(message: "HelloUnko2", condition: .normal, postedAt: Date(timeIntervalSinceNow: -2))))
        _entities.append(FeelingEntityImpl(id: 3, feeling: Feeling(message: "HelloUnko3\nThis\nIs\n3", condition: .normal, postedAt: Date(timeIntervalSinceNow: -1))))
        _entities.append(FeelingEntityImpl(id: 4, feeling: Feeling(message: "HelloUnko4", condition: .normal, postedAt: Date(timeIntervalSinceNow:  0))))
        return self
    }

    func fetchEntities() -> [FeelingEntity] {
        return _entities
    }
    func update(entities: [FeelingEntity]) {
        _entities = entities
    }
}
