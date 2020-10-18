//
//  RegexManager.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

final class DataValidator {
    
    static func validateEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
}
