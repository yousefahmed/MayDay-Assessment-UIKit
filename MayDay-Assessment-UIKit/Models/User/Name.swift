//
//  Name.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation

// MARK: Name
struct Name: Codable {
    let title, first, last: String
    
    var fullName: String {
        return title + " " + first + " " + last
    }
}
