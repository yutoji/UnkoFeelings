import Foundation
import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var _cellHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var _messageLabel: UILabel!
    @IBOutlet weak var _balloon: UIView!
    @IBOutlet weak var _iconLayer: UIView!
    private var _icon: UIView!

    static let ICON_SIDE_LENGTH: CGFloat = 64.0
    let balloonCornerRadius: CGFloat = 4.0
    //ISSUE: Should use IBOutlet constraint instead?
    static let CELL_MIN_HEIGHT: CGFloat = 8.0 + ICON_SIDE_LENGTH + 8
    let cellMinHeight: CGFloat = LogCell.CELL_MIN_HEIGHT
    // the total margins for _messageLabel
    let labelSizeDifferenceWithCellHorizontal: CGFloat = 8.0 + 64 + 8 + 8 + 0 + 8 + 8
    let labelSizeDifferenceWithCellVertical  : CGFloat = 8.0 + 8 + 0 + 8 + 8
    var deviceService: DeviceService = ApplicationDeviceService()

    var model: LogCellModelProtocol! {
        didSet {
            _update()
        }
    }

    override func awakeFromNib() {
        _balloon.layer.cornerRadius = balloonCornerRadius
        _iconLayer.backgroundColor = nil
        selectionStyle = .none
    }

    private func _update() {
        _messageLabel.text = model.message
        _cellHeightConstraint.constant = _calcOptimizedCellHeight()

        // setting FeelingCondition image
        for subview in _iconLayer.subviews { subview.removeFromSuperview() }
        _icon = UIImageView(image: model.conditionImage)
        _icon.frame.size = _iconLayer.frame.size
        _iconLayer.addSubview(_icon)
    }

    private func _calcOptimizedCellHeight() -> CGFloat {
        let applicationWidth = deviceService.currentWindowSize.width
        let labelMaxWidth  = applicationWidth - labelSizeDifferenceWithCellHorizontal
        let estimatedLabelHeight = ViewUtil.calcLabelHeight(label: _messageLabel, width: labelMaxWidth)
        let neededCellHeight = estimatedLabelHeight + labelSizeDifferenceWithCellVertical
        let cellHeight = max(neededCellHeight, cellMinHeight)
        return cellHeight
    }

    //MARK: - Animation procedures

    var animateModel: LogCellAnimateModelProtocol? {
        didSet {
            _beginAnimate()
        }
    }

    private func _beginAnimate() {
        guard let viewInfo = animateModel?.viewInfo else {
            assertionFailure()
            return
        }
        _icon.layer.removeAllAnimations()
        _icon.alpha = viewInfo.iconAlpha
        let iconOriginX: CGFloat = 0.0
        let iconMaxDiffX: CGFloat = type(of: self).ICON_SIDE_LENGTH
        _icon.frame.origin = CGPoint(x: iconOriginX - iconMaxDiffX * viewInfo.iconPositionDiffRatio, y: 0)
        if viewInfo.needsAnimate {
            UIView.animate(withDuration: viewInfo.durationRest) {
                self._icon.alpha = 1.0
                self._icon.frame.origin = CGPoint(x: iconOriginX, y: 0)
            }
        }
    }
}
