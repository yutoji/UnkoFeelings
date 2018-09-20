import Foundation

class LogCellModelFactory {
    private var _entityIdToCellModel: [String:LogCellModel] = [:]

    func getOrCreate(entity: FeelingEntity) -> LogCellModel {
        if let model = _entityIdToCellModel[entity.id] {
            return model
        }
        let model = LogCellModel(feeling: entity.feeling)
        _entityIdToCellModel[entity.id] = model
        return model
    }
}
