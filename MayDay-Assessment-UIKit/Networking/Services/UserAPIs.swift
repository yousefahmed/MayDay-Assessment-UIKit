//
//  UserAPIs.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

enum UserEndpoints: DataRequest {
    case loadUsers(limit: Int)
    
    var url: String {
        return APIEnvironment.current.baseURL() + path
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: [String : Any] {
        switch self {
        case .loadUsers(let limit):
            return ["results" : limit]
        }
    }
}

protocol UserLoader: AnyObject {
    @discardableResult
    func loadUsers(limit: Int, completion: @escaping User.resultsHandler, errorCompletion: @escaping NetworkService.ErrorHandler<Error>) -> URLSessionDataTask?
}
