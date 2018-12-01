//
//  NetworkClient.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Alamofire
import AlamofireNetworkActivityIndicator
import RxAlamofire
import RxSwift

final class NetworkClient: NetworkClientProtocol
{
    static let HostName = "https://api.github.com"

    let sessionManager: SessionManager
    let mapper: NetworkClientObjectMapper
    
    static var TrustedHosts: Set<String> {
        return [self.HostName]
    }
    
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
        NetworkClient.HostName: .disableEvaluation
    ]
    
    init(mapper: NetworkClientObjectMapper) {
        self.mapper = mapper
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0.5
        NetworkActivityIndicatorManager.shared.completionDelay = 0.3
        
        self.sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    let disposeBag = DisposeBag()
}

extension NetworkClient
{
    enum UsersRouter: URLRequestConvertible {
        case getUsers(page: Int, limit: Int)
        
        func asURLRequest() throws -> URLRequest {
            switch self {
            case .getUsers(let page, let limit):
                let path = "\(NetworkClient.HostName)/users"
                var urlRequest = URLRequest(url: URL(string: path)!)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                let parameters: [String: Any] = ["page": page, "per_page": limit]
                return try URLEncoding.default.encode(urlRequest, with: parameters)
            }
        }
    }
}

extension NetworkClient
{
//    func getUsers(page: Int,
//                  limit: Int,
//                  success: ((_ result: GetUsersResult?) -> Void)?,
//                  failure: ErrorCompletion?)
//    {
//        let request = UsersRouter.getUsers(page: page, limit: limit)
//        let theMapper = mapper
//        
//        sessionManager.rx.request(urlRequest: request)
//            .validate()
//            .responseJSON()
//            .map { response in
//                return try theMapper.getUsersResponseMap(response)
//            }
//            .subscribe { event in
//                switch event
//                {
//                case .completed:
//                    break
//                case .error(let error):
//                    failure?(error)
//                case .next(let users):
//                    success?(users)
//                }
//            }
//            .disposed(by: disposeBag)
//    }
    
    func getUsers(page: Int, limit: Int) -> Observable<GetUsersResult?>
    {
        let request = UsersRouter.getUsers(page: page, limit: limit)
        let theMapper = mapper
        
        return sessionManager.rx.request(urlRequest: request)
            .validate()
            .responseJSON()
            .map { response in
                return try theMapper.getUsersResponseMap(response)
        }
    }
}
