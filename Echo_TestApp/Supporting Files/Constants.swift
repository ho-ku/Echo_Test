//
//  Constants.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

// MARK: - SignUpConstants
struct SignUpC {
    static let signUpWelcomeText = "Welcome to Echo!"
    static let logInWelcomeText = "Welcome back!"
    static let logIn = "Log In"
    static let signUp = "Sign Up"
    static let signUpBottomText = "Already have an account?"
    static let logInBottomText = "Don't have an account?"
}

// MARK: - Constants
struct C {
    static let userNameKey: String = "userName"
    static let accessTokenKey: String = "accessToken"
    static let blankFieldsMessage: String = "Some of the fields are blank"
    static let invalidEmailMessage: String = "Invalid email"
    static let oops: String = "Oops.."
    static let signUpErrorMessage: String = "Sign Up Error"
    static let textFetchErrorMessage: String = "Fetch Error"
    static let mainViewCellIdentifier: String = "Cell"
}
