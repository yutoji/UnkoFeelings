class DelegateContainer<Delegate> {
    private var _delegates: [_Weak<Delegate>] = []

    func add(delegate: Delegate) {
        _delegates.append( _Weak(delegate) )
        _cleanGarbage()
    }

    func doEachDelegate(_ callback: (Delegate) -> Void) {
        for reference in _delegates {
            if let delegate = reference.object {
                callback(delegate)
            }
        }
        _cleanGarbage()
    }

    private func _cleanGarbage() {
        _delegates = _delegates.filter({$0.object != nil})
    }

}

fileprivate class _Weak<T> {
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
