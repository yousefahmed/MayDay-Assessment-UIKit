//
//  DataRequest.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

protocol DataRequest {
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any] { get }
}

enum HTTPMethod: String, Equatable {
    case `get` = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

