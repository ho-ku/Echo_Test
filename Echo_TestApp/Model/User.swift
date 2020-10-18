//
//  User.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

final class User {
    // MARK: - Properties
    var name: String
    var accessToken: String
    // Singleton
    static let shared = User()
    
    // MARK: - Init
    private init() {
        guard let name = UserDefaults.standard.value(forKey: C.userNameKey) as? String, let token = UserDefaults.standard.value(forKey: C.accessTokenKey) as? String else {
            self.name = ""
            self.accessToken = ""
            return
        }
        self.name = name
        self.accessToken = token
    }
    
    func save() {
        UserDefaults.standard.set(self.name, forKey: C.userNameKey)
        UserDefaults.standard.set(self.accessToken, forKey: C.accessTokenKey)
    }
}
