import Foundation

class VolatileFeelingRepository: FeelingRepository {
    private var _entities: [FeelingEntity] = []
    private var _creator: FeelingEntityCreatable

    init(_ entityCreator: FeelingEntityCreatable) {
        _creator = entityCreator
    }

    func insertMockData() -> VolatileFeelingRepository {
        _entities.append(_creator.create(feeling: Feeling(message: "ぷにぷに♡", condition: .soft, postedAt: Date(timeIntervalSinceNow: -5))))
        _entities.append(_creator.create(feeling: Feeling(message: "FREEEEEEEEEEEEEEEEEEEEEEEEEZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", condition: .hard, postedAt: Date(timeIntervalSinceNow:  -4))))
        _entities.append(_creator.create(feeling: Feeling(message: "元気なうんこだよ！", condition: .normal, postedAt: Date(timeIntervalSinceNow: -3))))
        _entities.append(_creator.create(feeling: Feeling(message: "ちょっと・・・やわらかかったなぁ", condition: .soft, postedAt: Date(timeIntervalSinceNow: -2))))
        _entities.append(_creator.create(feeling: Feeling(message: "今日は！！\nカッ...\nカタイ\nZE☆☆", condition: .hard, postedAt: Date(timeIntervalSinceNow: -1))))
        _entities.append(_creator.create(feeling: Feeling(message: "Feeling good to me :)", condition: .normal, postedAt: Date(timeIntervalSinceNow:  0))))
        return self
    }

    func fetchEntities() -> [FeelingEntity] {
        return _entities
    }
    func update(entities: [FeelingEntity]) {
        _entities = entities
    }
}
