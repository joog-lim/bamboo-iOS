struct LoginRequest : ModelType{
    let authorization : String
    enum CodingKeys : String , CodingKey{
        case authorization  = "Authorization"
    }
    
    static func == (lhs: LoginRequest, rhs: LoginRequest) -> Bool {
        lhs.authorization == rhs.authorization
    }
}
