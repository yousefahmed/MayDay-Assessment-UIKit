//
//  UserService.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

final class UserService: UserLoader {
    
    @discardableResult
    func loadUsers(limit: Int = 20, completion: @escaping User.resultsHandler, errorCompletion: @escaping NetworkService.ErrorHandler<Error>) -> URLSessionDataTask? {
        return NetworkService.call(router: UserEndpoints.loadUsers(limit: limit)) { data, statusCode, error in
            guard error == nil else {
                errorCompletion(error!)
                return
            }
            
            
            guard let data = data else {
                errorCompletion(APIError.decodingError)
                return
            }
            
            do {
                let users: Result<User> = try data.decode()
                completion(users)
            } catch {
                errorCompletion(APIError.decodingError)
            }
        }
    }
    
}
