import UIKit

class InputViewController: UIViewController, UITextViewDelegate, InputViewModelDelegate {

    @IBOutlet weak var _inputTextView: UITextView! {
        didSet {
            _inputTextView.delegate = self
        }
    }
    @IBOutlet weak var _submitButton: UIButton!
    @IBAction func _onSubmit(_ sender: Any) {
        guard _viewModel.isSubmittable else {
            return
        }
        _viewModel.submit()
    }
    @IBOutlet weak var _conditionLayer: UIView!
    @IBOutlet weak var _pickerView: UIPickerView!

    private var _viewModel: InputViewModel!
    var timeline: FeelingTimelineUpdatable!

    private var _conditionPresenter: _ConditionPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        _viewModel = InputViewModel(timeline: timeline)
        _viewModel.delegate = self
        _conditionPresenter = _ConditionPresenter(layerView: _conditionLayer, pickerView: _pickerView, viewModel: _viewModel)

        _viewModel.clearText()
    }

    //MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        _viewModel.text = textView.text
    }

    //MARK: - InputViewModelDelegate

    func onInputViewModelUpdated() {
        if _inputTextView.text != _viewModel.text {
            _inputTextView.text = _viewModel.text
        }
        _submitButton.isEnabled = _viewModel.isSubmittable
        _conditionPresenter.updateView()
    }

}

fileprivate class _ConditionPresenter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    private var _model: InputViewModel
    private var _layerView:UIView
    private var _pickerView: UIPickerView

    init(layerView: UIView, pickerView: UIPickerView, viewModel: InputViewModel) {

        _layerView = layerView
        _pickerView = pickerView
        _model = viewModel

        super.init()

        _pickerView.delegate = self
        _pickerView.dataSource = self

        _layerView.backgroundColor = nil

        updateView()
    }

    func updateView() {
        if _pickerView.selectedRow(inComponent: 0) != _model.conditionIndex {
            _pickerView.selectRow(_model.conditionIndex, inComponent: 0, animated: false)
        }

        for subview in _layerView.subviews {
            subview.removeFromSuperview()
        }
        let conditionView = UIImageView(image: UIImage(named: _model.condition.imageFileName))
        conditionView.contentMode = .scaleAspectFit
        conditionView.translatesAutoresizingMaskIntoConstraints = false

        _layerView.addSubview(conditionView)
        _layerView.addConstraints(
            [
                conditionView.heightAnchor.constraint(equalTo: _layerView.heightAnchor),
                conditionView.topAnchor.constraint(equalTo: _layerView.topAnchor),
                conditionView.centerXAnchor.constraint(equalTo: _layerView.centerXAnchor),
            ]
        )
    }

    //MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        assert(component == 0)
        return _model.pickableConditions.count
    }

    //MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return _model.pickableConditions[row].pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _model.condition = _model.pickableConditions[row]
    }
}
