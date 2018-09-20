protocol FeelingRepository {
    func fetchEntities() -> [FeelingEntity]
    func update(entities: [FeelingEntity])
}
