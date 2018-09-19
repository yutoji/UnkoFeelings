import Foundation
import UIKit

protocol DeviceService {
    var currentWindowSize: CGSize { get }
}

class ApplicationDeviceService: DeviceService {
    var currentWindowSize: CGSize {
        let window = UIApplication.shared.keyWindow!
        return window.bounds.size
    }
}

struct StubDeviceService: DeviceService {
    var currentWindowSize: CGSize
}
