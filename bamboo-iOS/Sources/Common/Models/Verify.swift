struct Verify : ModelType{
    var id , question : String
    enum CodingKeys : String,CodingKey{
        case id
        case question
    }
    static func  == (lhs : Verify, rhs : Verify) -> Bool{
        lhs.id == rhs.id
    }
}
