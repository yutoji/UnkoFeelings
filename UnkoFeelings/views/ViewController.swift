import UIKit

class ViewController: UITabBarController, FeelingTimelineDelegate {

    private var _repository: FeelingRepository!
    private var _feelingTimeline: (FeelingTimeline & FeelingTimelineUpdatable)!
    private var _inputViewController: InputViewController!
    private var _logViewController: LogViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        _setupViewControllers()
        _setupFeelingTimeline()

        _inputViewController.timeline = _feelingTimeline
        _logViewController.timeline = _feelingTimeline
        _feelingTimeline.delegates.add(delegate: self)
    }

    private func _setupViewControllers() {
        _inputViewController = viewControllers![0] as! InputViewController
        _logViewController = viewControllers![1] as! LogViewController
    }

    private func _setupFeelingTimeline() {
        let entityCreator = FeelingEntityCreator(uniqueIDGenerator: DeviceUniqueIDGenerator())
        _repository = DocumentsFeelingRepository()
        _setupRepositoryWithMockDataIfNeeded()
        _feelingTimeline = FeelingTimelineImpl(repository: _repository, entityCreator: entityCreator)
    }

    private func _setupRepositoryWithMockDataIfNeeded() {
        if _repository.fetchEntities().count == 0 {
            DebugData.insertMockData(to: _repository)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - FeelingTimeLineDelegate
    func onFeelingTimelineUpdated() {
        selectedViewController = _logViewController
    }

}

