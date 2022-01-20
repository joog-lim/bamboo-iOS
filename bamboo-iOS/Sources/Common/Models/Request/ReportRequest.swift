struct ReportRequest : ModelType{
    let status: String = "REPORTED"
    let reason : String
    
    static func == (lhs: ReportRequest, rhs: ReportRequest) -> Bool {
        lhs.status == rhs.status
    }
}
