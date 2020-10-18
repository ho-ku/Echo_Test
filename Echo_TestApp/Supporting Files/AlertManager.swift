//
//  AlertManager.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

final class AlertManager {
    
    static func presentSimpleAlert(_ viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true)
    }
    
}
