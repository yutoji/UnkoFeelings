import UIKit

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LogCell", bundle: nil), forCellReuseIdentifier: "LogCell")
        }
    }

    var feelingTimeline: FeelingTimeline! {
        didSet { _initCellModels() }
    }

    private var _cellModels: [LogCellModel]!

    private func _initCellModels() {
        _cellModels = feelingTimeline.entities.map() { (entity) -> LogCellModel in
            return LogCellModel(feeling: entity.feeling)
        }
    }

    //TODO: Implement estimatedRowHeight and etc.

    //MARK: - UITableViewDataSource

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
