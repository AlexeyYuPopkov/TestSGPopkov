//
//  NetworkClientObjectMapper+Users.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Foundation

typealias DataResponse = (HTTPURLResponse, Data)

extension NetworkClientObjectMapper
{
    func getUsersResponseMap(_ response: AlamofireDataResponse) throws -> GetUsersResult?
    {
        let theCode = try validateAlamofireResponse(response)
        
        switch theCode {
        case NetworkClientErrorCode.code200.rawValue:
            return try usersMap(data: response.data)
        default:
            throw NetworkClientError.unknown
        }
    }

    private func usersMap(data: Data?) throws -> GetUsersResult?
    {
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        return try decoder.decode(GetUsersResult.self, from: data)
    }
}
