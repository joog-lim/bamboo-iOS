struct Token : ModelType{
    let data : Datas
    struct Datas : ModelType{
        var access ,refresh: String
        var isAdmin : Bool
        enum CodingKeys : String, CodingKey{
            case access =  "accessToken"
            case refresh = "refreshToken"
            case isAdmin
        }
        static func == (lhs: Datas, rhs: Datas) -> Bool {
            lhs.refresh == rhs.refresh
        }
    }
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.data == rhs.data
    }
}
