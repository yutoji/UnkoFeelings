import UIKit

class LogViewController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LogCell", bundle: nil), forCellReuseIdentifier: "LogCell")
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = LogCell.CELL_MIN_HEIGHT
        }
    }

    var timeline: FeelingTimeline! {
        didSet {
            _initCellModels()
            timeline.delegates.add(delegate: self)
        }
    }

    private var _cellModels: [LogCellModel]!
    private var _modelFactory: LogCellModelFactory = LogCellModelFactory()

    private func _initCellModels() {
        _cellModels = timeline.entities.map() { (entity) -> LogCellModel in
            let model = _modelFactory.getOrCreate(entity: entity)
            return model
        }
    }

    private var _animateModel = LogViewControllerAnimateModel(numAnimateCell: 6)

    func _initCellAnimateModel(row: Int) -> LogCellAnimateModel {
        let entity = timeline.entities[row]
        if let cellAnimateModel = _animateModel.idTocellAnimateModel[entity.id] {
            return cellAnimateModel
        }
        let startRatio = _animateModel.publishNextAnimateOffsetRatio()
        let progress = TimeProgress(dateMaker: DateMaker())
        let cellAnimateModel = LogCellAnimateModel(startProgressRatio: startRatio, progress: progress)
        cellAnimateModel.startProgressTimer()
        _animateModel.idTocellAnimateModel[entity.id] = cellAnimateModel
        return cellAnimateModel
    }
}

//MARK: - UITableViewDelegate
extension LogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! LogCell
        let cellAnimateModel = _initCellAnimateModel(row: indexPath.row)
        cell.animateModel = cellAnimateModel
    }
    //TODO: Implement estimatedRowHeight and etc.
}

//MARK: - UITableViewDataSource
extension LogViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(indexPath.section == 0)

        let logCell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogCell
        let cellModel = _cellModels[indexPath.row]
        logCell.model = cellModel
        return logCell
    }
}

//MARK: - FeelingTimelineDelegate
extension LogViewController : FeelingTimelineDelegate {
    func onFeelingTimelineUpdated() {
        _initCellModels()

        if isViewLoaded {
            tableView.reloadData()
        }
    }
}

class LogViewControllerAnimateModel {
    static let RESET_DELAY: TimeInterval = TimeInterval.leastNonzeroMagnitude
    private let _numAnimateCell: Int
    private var _animateCellIndex: Int = 0
    private var _hasResetReserved: Bool = false

    init(numAnimateCell: Int) {
        _numAnimateCell = numAnimateCell
    }

    func publishNextAnimateOffsetRatio() -> Double {
        let offsetRatio = Double(_animateCellIndex) / Double(_numAnimateCell)
        _animateCellIndex += 1
        _resetIndexAfter()
        return min(offsetRatio, 1.0)
    }
    private func _resetIndexAfter() {
        if _hasResetReserved {
            return
        }
        _hasResetReserved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + type(of: self).RESET_DELAY) {
            self._animateCellIndex = 0
            self._hasResetReserved = false
        }
    }

    /// FeelingEntity.id to LogCellAnimateModel
    var idTocellAnimateModel: [String:LogCellAnimateModel] = [:]
}
