import Foundation

protocol FeelingEntity {
    var id: Int { get }
    var feeling: Feeling { get }
}

class FeelingEntityImpl: FeelingEntity {
    var id: Int
    var feeling: Feeling

    init(id: Int, feeling: Feeling) {
        self.id = id
        self.feeling = feeling
    }
}

protocol FeelingEntityCreatable {
    func create(id: Int, feeling: Feeling) -> FeelingEntity
}

class FeelingEntityCreator: FeelingEntityCreatable {
    private var _createdIds: [Int] = []
    func create(id: Int, feeling: Feeling) -> FeelingEntity {
        assert(_createdIds.index(of: id) == nil, "id dup. \(id) in \(_createdIds)")
        _createdIds.append(id)
        return FeelingEntityImpl(id: id, feeling: feeling)
    }
}
