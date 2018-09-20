import Foundation

protocol FeelingEntity {
    var id: String { get }
    var feeling: Feeling { get }
}

class FeelingEntityImpl: FeelingEntity {
    var id: String
    var feeling: Feeling

    init(id: String, feeling: Feeling) {
        self.id = id
        self.feeling = feeling
    }
}

protocol FeelingEntityCreatable {
    func create(feeling: Feeling) -> FeelingEntity
}

class FeelingEntityCreator: FeelingEntityCreatable {
    private var _uniqueIDGenerator: UniqueIDGenerator

    init(uniqueIDGenerator: UniqueIDGenerator) {
        _uniqueIDGenerator = uniqueIDGenerator
    }

    func create(feeling: Feeling) -> FeelingEntity {
        let id = _uniqueIDGenerator.generate()
        return FeelingEntityImpl(id: id, feeling: feeling)
    }
}
