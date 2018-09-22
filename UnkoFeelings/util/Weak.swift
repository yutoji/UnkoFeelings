import Foundation

class Weak<T> {
    weak var _object: AnyObject?
    var object: T? {
        return _object as? T
    }

    ///
    /// - Parameter object: must be a class type object
    init(_ object: T?) {
        _object = object as AnyObject
        assert(_object != nil, "Cast to AnyObject failed. 'object' must be a class type object. \(String(describing: object))")
    }
}
