struct Login : ModelType{
    let data : Datas
    struct Datas : ModelType{
        var access ,refresh: String
        var admin : Bool
        
        enum CodingKeys : String, CodingKey{
            case access =  "accessToken"
            case refresh = "refreshToken"
            case admin = "isAdmin"
        }
        static func == (lhs: Datas, rhs: Datas) -> Bool {
            lhs.refresh == rhs.refresh
        }
    }
    static func == (lhs: Login, rhs : Login) -> Bool{
        lhs.data == rhs.data
    }
}
