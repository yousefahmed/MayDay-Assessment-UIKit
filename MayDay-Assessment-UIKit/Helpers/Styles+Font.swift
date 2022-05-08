//
//  Styles+Font.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import UIKit

enum Montserrat: String {
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
    case extraBold = "Montserrat-ExtraBold"
    case black = "Montserrat-Black"
    
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: self.rawValue, size: size)
    }
}
