//
//  NetworkClientObjectMapper.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Alamofire

typealias SELF = NetworkClientObjectMapper
typealias AlamofireDataResponse = Alamofire.DataResponse<Any>

enum NetworkClientError : Error
{
    case unknown
    case noNetworkAvailable
    case notFound(Error)
    case internalServerError(Error)
}

enum NetworkClientErrorCode: Int
{
    case code200 = 200
    case code404 = 404
    case code500 = 500
}

final class NetworkClientObjectMapper
{
    let reachability = NetworkReachabilityManager(host: NetworkClient.HostName)!
    
    init() {
        self.startListeningReachability()
    }
}

// MARK:

extension NetworkClientObjectMapper
{
    static var isLogSuccess = false
    static var isLogFailure = true
    
    func startListeningReachability()
    {
        reachability.listener = { status in
            
            switch status {
            case .unknown:
                DLog("Network status unknown...")
            case .notReachable:
                DLog("Network isn't Reachable...")
            case .reachable(_): // ConnectionType
                DLog("Network is Reachable...")
            }
        }
        
        reachability.startListening()
    }
}

// MARK: Validate Alamofire Response

extension NetworkClientObjectMapper
{
    func validateError(_ anError: Error?) -> NetworkClientError
    {
        guard let error = anError else {
            if reachability.isReachable {
                return .unknown
            } else {
                return .noNetworkAvailable
            }
        }
        
        let code = (error as NSError).code
        
        guard let commonErrorCode = NetworkClientErrorCode(rawValue: code) else {
            if reachability.isReachable {
                return .unknown
            } else {
                return .noNetworkAvailable
            }
        }
        
        switch commonErrorCode {
        case .code404:
            return .notFound(error)
        case .code500:
            return .internalServerError(error)
        case let code where code.rawValue < -999:
            return .noNetworkAvailable
        default:
            return .unknown
        }
    }
    
    func validateAlamofireResponse<T>(_ aResponse: Alamofire.DataResponse<T>?) throws -> Int
    {
        guard let response = aResponse else {
            if reachability.isReachable {
                throw NetworkClientError.unknown
            } else {
                throw NetworkClientError.noNetworkAvailable
            }
        }
        
        switch response.result
        {
        case .success:
            #if DEBUG
            if SELF.isLogSuccess {
                SELF.logAlamofireDataResponse(response)
            }
            #endif
            
            if let theCode = response.response?.statusCode {
                DLog("theCode = \(theCode)")
                #if DEBUG
                if theCode != NetworkClientErrorCode.code200.rawValue && SELF.isLogFailure {
                    SELF.logAlamofireDataResponse(response)
                }
                #endif
                return theCode
            }
            else {
                throw NetworkClientError.unknown
            }
        case .failure(let error):
            #if DEBUG
            if SELF.isLogFailure {
                SELF.logAlamofireDataResponse(response)
                DLog("Error: \(error.localizedDescription)")
            }
            #endif
            
            guard let code = response.response?.statusCode else {
                if reachability.isReachable {
                    throw NetworkClientError.unknown
                } else {
                    throw NetworkClientError.noNetworkAvailable
                }
            }
            
            guard let commonErrorCode = NetworkClientErrorCode(rawValue: code) else {
                if reachability.isReachable {
                    throw NetworkClientError.unknown
                } else {
                    throw NetworkClientError.noNetworkAvailable
                }
            }
            
            switch commonErrorCode {
            case .code404:
                throw NetworkClientError.notFound(error)
            case .code500:
                throw NetworkClientError.internalServerError(error)
            case let code where code.rawValue < -999:
                throw NetworkClientError.noNetworkAvailable
            default:
                return code
            }
        }
    }
}

// MARK: Logging

extension NetworkClientObjectMapper
{
    static private func logAlamofireDataResponse<T>(_ response: Alamofire.DataResponse<T>?) {
        #if DEBUG
        DLog(self.debugDescription(response))
        #endif
    }
    
    static func debugDescription<T>(_ response: Alamofire.DataResponse<T>?) -> String
    {
        guard let response = response else {
            return "Unknown Error"
        }
        
        var result = [String]()
        
        if let requestDescription = self.requestDescription(response.request) {
            result.append(requestDescription)
        }
        
        if let httpResponseDescription = self.httpResponseDescription(response) {
            result.append(httpResponseDescription)
        }
        
        
        return result.joined(separator: "\n")
    }
    
    static func httpResponseDescription<T>(_ aResponse: Alamofire.DataResponse<T>?) -> String?
    {
        guard let response = aResponse else {
            return nil
        }
        
        var result = [String]()
        
        result.append("Response:")
        
        if let code = response.response?.statusCode {
            result.append("\tStatusCode: \(code)")
        }
        
        if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
            result.append("\tResult Data: \(dataString)")
        }
        
        if let error = response.error as NSError? {
            result.append("\tError: \(error.localizedDescription)")
        }
        
        return result.joined(separator: "\n")
    }
    
    static func requestDescription(_ aRequest: URLRequest?) -> String?
    {
        guard let request = aRequest else {
            return nil
        }
        
        var result = [String]()
        
        result.append("Request:")
        
        if let url = request.url {
            result.append("\tURL: \(url.absoluteString)")
        }
        
        if let method = request.httpMethod {
            result.append("\tMethod: \(method)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            result.append("\tHeaders:")
            for (key, val) in headers {
                result.append("\t\t\(key): \(val)")
            }
        }
        
        if let body = request.httpBody,
            let bodyString = String(data: body, encoding: .utf8) {
            result.append("\tHttpBody: \(bodyString)")
        }
        
        return result.joined(separator: "\n")
    }
}



