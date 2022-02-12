struct Verify : ModelType{
    var data : Datas
    
    struct Datas : ModelType{
        var id , question : String
        enum CodingKeys : String,CodingKey{
            case id
            case question
        }
        static func  == (lhs : Datas, rhs : Datas) -> Bool{
            lhs.id == rhs.id
        }
    }

}
