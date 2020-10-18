//
//  ViewController.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

final class MainVC: UIViewController {
 
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if User.shared.name == "" {
            Router.presentSignUpView(from: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Request operations
        print(User.shared.accessToken)
    }

}

