enum FeelingCondition {
    case normal
    case soft
    case hard

    static var cases: [FeelingCondition] {
        return [.normal, .soft, .hard]
    }

    var imageFileName: String {
        switch self {
        case .normal: return "unchi_character"
        case   .soft: return "unchi_character_yawarakai"
        case   .hard: return "unchi_character_katai"
        }
    }
}
