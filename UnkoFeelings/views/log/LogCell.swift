import Foundation
import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var _cellHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var _messageLabel: UILabel!
    @IBOutlet weak var _balloon: UIView!
    @IBOutlet weak var _iconLayer: UIView!

    let balloonCornerRadius: CGFloat = 4.0
    //ISSUE: Should use IBOutlet constraint instead?
    let iconLayerSize: CGSize = CGSize(width: 64.0, height: 64.0)
    let cellMinHeight: CGFloat = 8.0 + 64 + 8
    // the total margins for _messageLabel
    let labelSizeDifferenceWithCellHorizontal: CGFloat = 8.0 + 64 + 8 + 8 + 0 + 8 + 8
    let labelSizeDifferenceWithCellVertical  : CGFloat = 8.0 + 8 + 0 + 8 + 8
    var deviceService: DeviceService = ApplicationDeviceService()

    var model: LogCellModel! {
        didSet {
            _update()
        }
    }

    override func awakeFromNib() {
        _balloon.layer.cornerRadius = balloonCornerRadius
    }

    private func _update() {
        _messageLabel.text = model.message
        _cellHeightConstraint.constant = _calcOptimizedCellHeight()
    }

    private func _calcOptimizedCellHeight() -> CGFloat {
        let applicationWidth = deviceService.currentWindowSize.width
        let labelMaxWidth  = applicationWidth - labelSizeDifferenceWithCellHorizontal
        let estimatedLabelHeight = ViewUtil.calcLabelHeight(label: _messageLabel, width: labelMaxWidth)
        let neededCellHeight = estimatedLabelHeight + labelSizeDifferenceWithCellVertical
        let cellHeight = max(neededCellHeight, cellMinHeight)
        return cellHeight
    }

}
