import Foundation

protocol DateMakable {
    func make() -> Date
}

class DateMaker: DateMakable {
    func make() -> Date {
        return Date()
    }
}

class StubDateMaker: DateMakable {
    var stub: Date!
    func make() -> Date {
        return stub
    }
}
