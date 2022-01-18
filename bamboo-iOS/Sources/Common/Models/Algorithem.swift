struct Algorithm : ModelType{
    var result : [Results]
    
    struct Results: ModelType{
        var idx  : Int
        var algorithmNumber : Int
        var title : String
        var content : String
        var tag : String
        var reason : String?
        var createdAt : String
        var isClicked : Bool
        var emojiCount : Int
        
        enum CodingKeys : String,CodingKey{
            case idx
            case algorithmNumber
            case title
            case content
            case tag
            case reason
            case createdAt
            case isClicked
            case emojiCount
        }
        
        static func == (lhs : Results, rhs : Results) -> Bool{
            lhs.idx == rhs.idx
        }
    }
    
    static func == (lhs : Algorithm, rhs : Algorithm) -> Bool{
        lhs.result == rhs.result
    }
}

