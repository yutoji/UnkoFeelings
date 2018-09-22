import UIKit

class LogViewController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LogCell", bundle: nil), forCellReuseIdentifier: "LogCell")
            tableView.separatorStyle = .none
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
            return _modelFactory.getOrCreate(entity: entity)
        }
    }
}

//MARK: - UITableViewDelegate
extension LogViewController: UITableViewDelegate {
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
