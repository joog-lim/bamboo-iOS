struct AlgorithmRequest : ModelType{
    let count : Int? = 5
    let page: Int
    let status : String? = "ACCEPTED"
    
    enum CodingKeys : String , CodingKey{
        case count
        case page
        case status
    }
}
