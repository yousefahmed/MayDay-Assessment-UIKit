//
//  APIEnviroment.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    static var current: APIEnvironment {
        #if DEBUG
        return APIEnvironment.development
        #else
        return APIEnvironment.production
        #endif
    }
    
    func baseURL () -> String {
        return "https://\(domain())/\(route())/"
    }
    
    func domain() -> String {
        return "randomuser.me"
    }
    
    func route() -> String {
        return "api"
    }
}


