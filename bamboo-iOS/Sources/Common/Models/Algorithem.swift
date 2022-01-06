struct Algorithem : ModelType{
    var id  : String
    var number : Int
    var title : String
    var content : String
    var tag : String
    var createdAt : Int
    var reason : String?
}

extension Algorithem : Equatable{
    static func == (lhs : Algorithem, rhs : Algorithem) -> Bool{
        lhs.id == rhs.id
    }
}
