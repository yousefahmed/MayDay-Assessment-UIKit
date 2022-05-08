//
//  User.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

// MARK: - User
struct User: Codable {
    let name: Name
    let email: String
    let picture: Picture
    
}

extension User {
    typealias resultsHandler = (_ result: Result<User>) -> ()
}
