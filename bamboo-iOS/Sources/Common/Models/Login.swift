struct Login : ModelType{
    var access ,refresh: String
    
    enum CodingKeys : String, CodingKey{
        case access =  "accessToken"
        case refresh = "refreshToken"
    }
    static func == (lhs: Login, rhs: Login) -> Bool {
        lhs.refresh == rhs.refresh
    }
}

