import XCTest
@testable import UnkoFeelings

class DelegateContainerTests: XCTestCase {

    private var _container: DelegateContainer<_Delegate>!
    private var _delegate: _DelegateStub!
    
    override func setUp() {
        super.setUp()
        _container = DelegateContainer<_Delegate>()
        _delegate = _DelegateStub()
        _container.add(delegate: _delegate)
    }

    func testDelegateCall() {
        XCTAssertEqual(_delegate.calledCount, 0)

        _container.doEachDelegate({ $0.doSomethingGreat() })
        XCTAssertEqual(_delegate.calledCount, 1)

        _container.doEachDelegate({ $0.doSomethingGreat() })
        XCTAssertEqual(_delegate.calledCount, 2)
    }

    func testMultipleDelegatesCall() {
        let secondDelegate = _DelegateStub()
        _container.add(delegate: secondDelegate)

        _container.doEachDelegate({ $0.doSomethingGreat() })
        XCTAssertEqual(_delegate.calledCount, 1)
        XCTAssertEqual(secondDelegate.calledCount, 1)

        _container.doEachDelegate({ $0.doSomethingGreat() })
        XCTAssertEqual(_delegate.calledCount, 2)
        XCTAssertEqual(secondDelegate.calledCount, 2)
    }

    func testGarbageCleanFeature() {
        weak var weakDelegate = _delegate

        _delegate = nil
        _container.doEachDelegate({ $0.doSomethingGreat() })

        XCTAssertNil(weakDelegate)
    }
}

fileprivate protocol _Delegate {
    func doSomethingGreat()
}

fileprivate class _DelegateStub : _Delegate {
    var calledCount: Int = 0
    func doSomethingGreat() {
        calledCount += 1
    }
}
