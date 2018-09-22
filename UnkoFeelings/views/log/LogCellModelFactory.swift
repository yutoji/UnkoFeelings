import Foundation

class LogCellModelFactory {
    private let _factory: _CachedModelFactory<FeelingEntity, LogCellModel>

    init() {
        _factory = _CachedModelFactory(modelToId: { (entity) -> String in
            return entity.id
        }, createViewModel: { (entity) -> LogCellModel in
            return LogCellModel(feeling: entity.feeling)
        })
    }

    func getOrCreate(entity: FeelingEntity) -> LogCellModel {
        return _factory.getOrCreate(model: entity)
    }
}

class LogCellViewModelFactory {
    private let _fatory: _CachedModelFactory<FeelingEntity, LogCellAnimateModel>

    init() {
        _fatory = _CachedModelFactory(modelToId: { (entity) -> String in
            return entity.id
        }, createViewModel: { (entity) -> LogCellAnimateModel in
            let timeProgress = TimeProgress(dateMaker: DateMaker())
            return LogCellAnimateModel(progress: timeProgress)
        })
    }

    func getOrCreate(entity: FeelingEntity) -> LogCellAnimateModel {
        return _fatory.getOrCreate(model: entity)
    }
}

fileprivate class _CachedModelFactory<Model, ViewModel> {
    private var _modelIdToViewModel: [String:ViewModel] = [:]

    private let _modelToId: (Model) -> String
    private let _createViewModel: (Model) -> ViewModel

    init(modelToId: @escaping (Model) -> String, createViewModel: @escaping (Model) -> ViewModel) {
        _modelToId = modelToId
        _createViewModel = createViewModel
    }

    func getOrCreate(model: Model) -> ViewModel {
        let modelId = _modelToId(model)

        if _modelIdToViewModel[modelId] == nil {
            let viewModel = _createViewModel(model)
            _modelIdToViewModel[modelId] = viewModel
        }

        return _modelIdToViewModel[modelId]!
    }
}
