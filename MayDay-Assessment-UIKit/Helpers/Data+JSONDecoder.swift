//
//  Data+JSONDecoder.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

extension Data {
    func decode<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
