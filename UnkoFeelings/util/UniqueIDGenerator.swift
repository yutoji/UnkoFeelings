import Foundation

protocol UniqueIDGenerator {
    func generate() -> String
}

class DeviceUniqueIDGenerator: UniqueIDGenerator {
    func generate() -> String {
        return UUID().uuidString
    }
}

class StubUniqueIDGenerator: UniqueIDGenerator {
    private var _createdCount: Int = 0
    private var _nextId: Int = 1

    func generate() -> String {
        let id = String(describing: _nextId)
        _nextId += 1
        _createdCount += 1
        return id
    }

    var createdCount: Int {
        return _createdCount
    }
}
