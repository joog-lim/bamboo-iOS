import Foundation
import RxSwift

protocol UserServiceType {
    //post
    func postBulletin(bulletinRequest: BulletinRequest) -> Observable<Base>
    func postEmoji(emojiRequest : EmojiRequest) -> Observable<Base>
    //get
    func getAlgorithm(algorithmRequest : AlgorithmRequest) -> Observable<Algorithm>
    func getRule() -> Observable<Rule>
    func getVerify() -> Observable<Verify>
}
final class UserService : BaseService,UserServiceType{}

//MARK: - Post
extension UserService{
    //Bulletin
    func postBulletin(bulletinRequest: BulletinRequest) -> Observable<Base> {
        BamBooAPI.postBulletin(bulletinRequest: bulletinRequest)
            .request()
            .map(Base.self)
            .do(onError:{print($0)})
            .asObservable()
    }
    //Emoji
    func postEmoji(emojiRequest: EmojiRequest) -> Observable<Base>{
        BamBooAPI.postEmoji(emojiRequest: emojiRequest)
            .request()
            .map(Base.self)
            .do(onError:{print($0)})
            .asObservable()
    }
}


//MARK: - Get
extension UserService {
    // - Algorithm
    func getAlgorithm(algorithmRequest: AlgorithmRequest) -> Observable<Algorithm>{
        BamBooAPI.getAlgorithm(algorithmRequest: algorithmRequest)
            .request()
            .map(Algorithm.self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
    // - Rule
    func getRule() -> Observable<Rule> {
        BamBooAPI.getRule
            .request()
            .map(Rule.self, using : BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
    // - Verify
    func getVerify() -> Observable<Verify>{
        BamBooAPI.getVerify
            .request()
            .map(Verify.self, using: BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
}
