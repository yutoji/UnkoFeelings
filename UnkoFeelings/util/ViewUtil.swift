import Foundation
import UIKit

class ViewUtil {

    static func calcLabelHeight(label: UILabel, width: CGFloat) -> CGFloat {
        return calcLabelHeight(text: label.text!, width: width, font: label.font, numberOfLines: label.numberOfLines)
    }

    static func calcLabelHeight(text: String, width: CGFloat, font: UIFont, numberOfLines: Int = 0) -> CGFloat {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        label.font = font
        label.numberOfLines = numberOfLines

        let labelSize = label.sizeThatFits(CGSize(
            width : width - label.layoutMargins.left - label.layoutMargins.right,
            height: CGFloat.greatestFiniteMagnitude
        ))
        return labelSize.height
    }

}
