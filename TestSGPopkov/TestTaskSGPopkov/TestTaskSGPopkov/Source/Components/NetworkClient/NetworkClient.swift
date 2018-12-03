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
}

extension NetworkClient
{
    enum UsersRouter: URLRequestConvertible {
        case getUsers(lastUserId: Int?, limit: Int)
        
        func asURLRequest() throws -> URLRequest {
            switch self {
            case .getUsers(let lastUserId, let limit):
                let path = "\(NetworkClient.HostName)/users"
                var urlRequest = URLRequest(url: URL(string: path)!)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                var parameters: [String: Any] = ["per_page": limit]
                if let lastUserId = lastUserId {
                    parameters["since"] = lastUserId
                }
                return try URLEncoding.default.encode(urlRequest, with: parameters)
            }
        }
    }
}

extension NetworkClient
{
    func getUsers(lastUserId: Int?, limit: Int) -> Observable<[GetUsersResult]>
    {
        let request = UsersRouter.getUsers(lastUserId: lastUserId, limit: limit)
        let theMapper = mapper
        
        return sessionManager.rx.request(urlRequest: request)
            .validate()
            .responseJSON()
            .map { response in
                return try theMapper.getUsersResponseMap(response)
        }
    }
}
