struct EmojiRequest : ModelType{
    let number: Int
    
    static func == (lhs: EmojiRequest, rhs: EmojiRequest) -> Bool {
        lhs.number == rhs.number
    }
}
