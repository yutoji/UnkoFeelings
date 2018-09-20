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
