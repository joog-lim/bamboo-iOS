struct BulletinRequest : ModelType{

    let title,content,tag : String?
//    let verify :
    enum CodingKeys : String, CodingKey{
        case title
        case content
        case tag
    }

    static func == (lhs: BulletinRequest, rhs: BulletinRequest) -> Bool {
        lhs.title == rhs.title
    }
}

