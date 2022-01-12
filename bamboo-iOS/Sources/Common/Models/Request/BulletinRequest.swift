struct BulletinRequest : ModelType{
    let title,content,tag : String
    let verify : Verifys
    
    enum CodingKeys : String, CodingKey{
        case title,content,tag
    }
    
    struct Verifys : ModelType{
        let id ,answer : String
    }
    
    static func == (lhs : BulletinRequest, rhs : BulletinRequest) -> Bool{
        lhs.title == rhs.title
    }
}
