//
//  UITableViewCell+Identifier.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-06.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
