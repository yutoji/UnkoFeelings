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

    private var _viewModel: InputViewModel!
    var timeline: FeelingTimelineUpdatable!

    override func viewDidLoad() {
        super.viewDidLoad()
        _viewModel = InputViewModel(timeline: timeline)
        _viewModel.delegate = self
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
    }
}
