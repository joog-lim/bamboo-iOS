struct AdminAlgorithmRequest : ModelType{
    let count : Int? = 5
    let page: Int
    let status : String
    
    enum CodingKeys : String , CodingKey{
        case count
        case page = "criteria"
        case status
    }
}
