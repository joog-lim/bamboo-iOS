struct EditAlgorithmRequest : ModelType{
    let title : String
    let content : String
    enum CodingKeys : String , CodingKey{
        case title
        case content
    }
    static func == (lhs: EditAlgorithmRequest, rhs: EditAlgorithmRequest) -> Bool {
        lhs.title == rhs.title
    }
}
