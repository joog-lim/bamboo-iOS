struct Login : ModelType{
    var access ,refresh: String
    var admin : Bool
    
    enum CodingKeys : String, CodingKey{
        case access =  "accessToken"
        case refresh = "refreshToken"
        case admin = "isAdmin"
    }
    static func == (lhs: Login, rhs: Login) -> Bool {
        lhs.refresh == rhs.refresh
    }
}
