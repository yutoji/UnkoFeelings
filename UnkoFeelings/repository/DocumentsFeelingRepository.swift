import Foundation

class DocumentsFeelingRepository: FeelingRepository {

    public static let DEFAULT_FILE_BASENAME = "feeling_entities.json"
    private let _customFilepath: URL?
    private var _objectPool: [String:FeelingEntity] = [:]

    init(filepathToSave: URL? = nil) {
        // use FileManager.default.temporaryDirectory for tests
        _customFilepath = filepathToSave
    }

    //ISSUE: Make json loader protocol in util package and replace the codes below to seperate device dependent code, and to be able to use stub loader for tests

    func fetchEntities() -> [FeelingEntity] {
        guard let pathUrl = getFileUrl() else {
            assertionFailure(String(describing: _customFilepath))
            //TODO: Show alert to user
            return []
        }

        // in case no data
        if !FileManager.default.fileExists(atPath: pathUrl.path) {
            return []
        }

        var record: ContainerRecord!
        do {
            record = try JSONDecoder().decode(ContainerRecord.self, from: Data(contentsOf: pathUrl))
        } catch {
            //TODO: Show alert to user instead below
            assertionFailure(String(describing: error))
        }
        let entities = record.entityRecords.map({ _entityOf(record: $0) })
        return entities
    }

    func update(entities: [FeelingEntity]) {
        let record = _makeCodable(entities: entities)
        let pathUrl = getFileUrl()
        do {
            let json = try JSONEncoder().encode(record)
            try json.write(to: pathUrl!)
        } catch {
            //TODO: Show alert to user instead below
            assertionFailure(String(describing: error))
        }
    }

    public func getFileUrl() -> URL? {
        if let url = _customFilepath {
            return url
        }
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = dirs.last
        let basename = DocumentsFeelingRepository.DEFAULT_FILE_BASENAME
        let filepath = URL(string: basename, relativeTo: dir)
        return filepath
    }

    //ISSUE: Should define this logic to domain package?
    private func _makeCodable(entities: [FeelingEntity]) -> ContainerRecord {
        let record = ContainerRecord(entityRecords: entities.map({
            EntityRecord(id: $0.id, feeling: $0.feeling)
        }))
        return record
    }

    private func _entityOf(record: EntityRecord) -> FeelingEntity {
        //ISSUE: Use object pool to avoid making same id entity objects.
        //ISSUE: Should not make FeelingEntry object in this class to control entity uniqueness. Not here but in the domain package is the answer.
        return FeelingEntityImpl(id: record.id, feeling: record.feeling)
    }

    struct ContainerRecord: Codable {
        var entityRecords: [EntityRecord]
    }

    //ISSUE: Should change FeelingEntity to Codable(struct) instead of converting it here?
    struct EntityRecord: Codable {
        var id: String
        var feeling: Feeling
    }
}

