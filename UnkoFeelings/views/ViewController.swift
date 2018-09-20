//

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
        _feelingTimeline.delegate = self
    }

    private func _setupViewControllers() {
        _inputViewController = viewControllers![0] as! InputViewController
        _logViewController = viewControllers![1] as! LogViewController
    }

    private func _setupFeelingTimeline() {
        let entityCreator = FeelingEntityCreator(uniqueIDGenerator: DeviceUniqueIDGenerator())
        _repository = MemoryFeelingRepository(entityCreator).insertMockData() // TODO: replace to actual repository object
        _feelingTimeline = FeelingTimelineImpl(repository: _repository, entityCreator: entityCreator)
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

