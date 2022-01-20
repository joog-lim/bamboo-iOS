struct Rule : ModelType{
    var content : String
    var thirteen ,fifteen: [String]
    
    enum CodingKeys: String, CodingKey{
        case content
        case thirteen = "bold13"
        case fifteen = "bold15"
    }
    static func == (lhs: Rule, rhs: Rule) -> Bool {
        lhs.content == rhs.content
    }
}
