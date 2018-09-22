class DelegateContainer<Delegate> {
    private var _delegates: [Weak<Delegate>] = []

    func add(delegate: Delegate) {
        _delegates.append( Weak(delegate) )
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
