//
//  Router.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

final class Router {
    // MARK: - Identifiers
    private struct I {
        static let mainNavigationVCIdentifier = "MainNavigationVC"
        static let signUpVCIdentifier = "SignUpVC"
    }
    
    static func presentSignUpView(from vc: UIViewController) {
        guard let signUpVC = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(withIdentifier: I.signUpVCIdentifier) as? SignUpViewController else { return }
        vc.present(signUpVC, animated: true)
    }
    
    static func presentMainView(from vc: UIViewController) {
        guard let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: I.mainNavigationVCIdentifier) as? UINavigationController else { return }
        vc.present(mainVC, animated: true)
    }
    
}
