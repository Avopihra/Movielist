//
//  Alert.swift
//  Movielist
//
//  Created by Viktoriya on 06.12.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                 message: String,
                 handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        let okAction = UIAlertAction(title: NSLocalizedString("okAction", comment: ""),
                               style: .default) {  (_) in
            handler?()
        }
        alert.addAction(okAction)
        present(alert,
                animated: true,
                completion: nil)
    }
}
