//
//  UIViewController+UIAlertController.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-07.
//

import UIKit

extension UIViewController {
    func showError(title: String, des: String, closure: @escaping ()-> () = {}) {
        let errorAlert = UIAlertController(title: title, message: des, preferredStyle: UIAlertController.Style.alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            closure()
        }))
        present(errorAlert, animated: true)
    }
}
