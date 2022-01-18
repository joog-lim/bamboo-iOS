struct AlgorithmRequest : ModelType{
    let count : Int? = 5
    let page: Int
    
    enum CodingKeys : String , CodingKey{
        case count
        case page = "criteria"
    }
}
