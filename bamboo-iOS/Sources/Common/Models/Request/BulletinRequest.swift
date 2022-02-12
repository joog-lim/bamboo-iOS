// MARK: - BulletinRequest
struct BulletinRequest: ModelType {
    let title, content, tag: String
    let verify: Verifys
    
    // MARK: - Verify
    struct Verifys: ModelType {
        let id, answer: String
    }
    
    static func == (lhs: BulletinRequest, rhs: BulletinRequest) -> Bool {
        lhs.title == rhs.title
    }
}

