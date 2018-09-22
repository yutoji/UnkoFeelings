import Foundation

class DebugData {
    static func insertMockData(to repository: FeelingRepository) {
        let creator = FeelingEntityCreator(uniqueIDGenerator: DeviceUniqueIDGenerator())
        var entities = repository.fetchEntities()
        entities.append(contentsOf: [
            creator.create(feeling: Feeling(message: "ぷにぷに♡", condition: .soft, postedAt: Date(timeIntervalSinceNow: -5))),
            creator.create(feeling: Feeling(message: "FREEEEEEEEEEEEEEEEEEEEEEEEEZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", condition: .hard, postedAt: Date(timeIntervalSinceNow:  -4))),
            creator.create(feeling: Feeling(message: "元気なうんこだよ！", condition: .normal, postedAt: Date(timeIntervalSinceNow: -3))),
            creator.create(feeling: Feeling(message: "ちょっと・・・やわらかかったなぁ", condition: .soft, postedAt: Date(timeIntervalSinceNow: -2))),
            creator.create(feeling: Feeling(message: "今日は！！\nカッ...\nカタイ\nZE☆☆", condition: .hard, postedAt: Date(timeIntervalSinceNow: -1))),
            creator.create(feeling: Feeling(message: "Feeling good to me :)", condition: .normal, postedAt: Date(timeIntervalSinceNow:  0))),
            ])
        for i in 0...10 {
            let timeDiff: TimeInterval = -Double(10 + i) * Double(entities.count)
            entities.insert(creator.create(feeling: Feeling(message: "Good shit \(11-i)!!", condition: .normal, postedAt: Date(timeIntervalSinceNow: timeDiff))), at: 0)
        }
        repository.update(entities: entities)
    }
}

