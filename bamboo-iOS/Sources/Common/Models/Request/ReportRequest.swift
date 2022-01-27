struct EditStatusRequest : ModelType{
    var status: String
    let reason : String
    
    static func == (lhs: EditStatusRequest, rhs: EditStatusRequest) -> Bool {
        lhs.status == rhs.status
    }
}
