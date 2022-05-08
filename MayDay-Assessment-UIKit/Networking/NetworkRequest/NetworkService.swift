//
//  NetworkService.swift
//  MayDay-Assessment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation
import UIKit

protocol NetworkProtocol: AnyObject {
    @discardableResult
    static func call(router: DataRequest, completion: @escaping (_ data: Data?, _ statusCode: Int?, _ error: Error?) -> ()) -> URLSessionDataTask?
    
    @discardableResult
    static func downloadImage(imageURL: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) -> URLSessionDataTask?
}

enum APIError: Error {
    case badRequest
    case forbidden
    case notFound
    case methodNotAllowed
    case conflict
    case internalServerError
    case unknown
    case decodingError
}

final class NetworkService: NetworkProtocol {
    
    public typealias ErrorHandler<T: Error> = (_ error: T) -> ()
    
    @discardableResult
    static func call(router: DataRequest, completion: @escaping (_ data: Data?, _ statusCode: Int?, _ error: Error?) -> ()) -> URLSessionDataTask? {
        
        guard var urlComponents = URLComponents(string: router.url) else {
            completion(nil, nil, APIError.methodNotAllowed)
            return nil }
        
        var queryItems: [URLQueryItem] = []
        
        if router.method == .get {
            router.params.forEach {
                let urlQueryItem = URLQueryItem(name: $0.key, value: "\($0.value)")
                queryItems.append(urlQueryItem)
            }
            
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            completion(nil, nil, APIError.badRequest)
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, nil, error!)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, nil, APIError.unknown)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, 400 <= response.statusCode {
                DispatchQueue.main.async {
                    completion(data, response.statusCode, NetworkService.handleResponse(response))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(data, (response as? HTTPURLResponse)?.statusCode, nil)
            }
        }
        
        task.resume()
        
        return task
    }
    
    
    
    static private func handleResponse(_ response: HTTPURLResponse) -> Error {
        let error: APIError
        switch response.statusCode {
        case 400:
            error = .badRequest
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 405:
            error = .methodNotAllowed
        case 409:
            error = .conflict
        case 500:
            error = .internalServerError
        default:
            error = .unknown
        }
        return error
    }
    
    
    
    @discardableResult
    static func downloadImage(imageURL: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) -> URLSessionDataTask? {
        let task = URLSession.shared.dataTask(with: imageURL) {  data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, APIError.unknown)
                }
                return
            }
            
            
            
            if let response = response as? HTTPURLResponse, 400 <= response.statusCode {
                DispatchQueue.main.async {
                    completion(nil, NetworkService.handleResponse(response))
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil, APIError.decodingError)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }
        
        task.resume()
        
        return task
    }
    
}



