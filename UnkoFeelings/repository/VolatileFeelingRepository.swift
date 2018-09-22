import Foundation

class VolatileFeelingRepository: FeelingRepository {
    private var _entities: [FeelingEntity] = []
    private var _creator: FeelingEntityCreatable

    init(_ entityCreator: FeelingEntityCreatable) {
        _creator = entityCreator
    }

    func insertMockData() -> VolatileFeelingRepository {
        DebugData.insertMockData(to: self)
        return self
    }

    func fetchEntities() -> [FeelingEntity] {
        return _entities
    }
    func update(entities: [FeelingEntity]) {
        _entities = entities
    }
}
