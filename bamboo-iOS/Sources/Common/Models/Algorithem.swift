struct Algorithm : ModelType{
    var idx  : Int
    var algorithmNumber : Int
    var title : String
    var content : String
    var tag : String
    var createdAt : String
    var isClicked : Bool
    var emojiCount : Int
    
    enum CodingKeys : String,CodingKey{
        case idx
        case algorithmNumber
        case title
        case content
        case tag
        case createdAt
        case isClicked
        case emojiCount
    }
}

extension Algorithm : Equatable{
    static func == (lhs : Algorithm, rhs : Algorithm) -> Bool{
        lhs.idx == rhs.idx
    }
}
