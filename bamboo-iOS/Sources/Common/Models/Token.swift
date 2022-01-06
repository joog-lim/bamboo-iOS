struct Token : ModelType{
    var access ,refresh: String
    
    enum CodingKeys : String, CodingKey{
        case access =  "accessToken"
        case refresh = "refreshToken"
    }
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.refresh == rhs.refresh
    }
}
