//
//  SignUpViewController.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

final class SignUpViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var signUpView: SignUpView!
    // MARK: - Properties
    private let requestManager = RequestManager()
    private var continueTyping = true
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.delegate = self
        // Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Removing observer for keyboard notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    private func performSignUpWith(name: String, email: String, password: String) {
        requestManager.signUpWith(name: name, email: email, password: password) { [unowned self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async { [unowned self] in
                    self.signUpView.finishLoading()
                    AlertManager.presentSimpleAlert(self, title: C.oops, message: C.signUpErrorMessage)
                }
            case .success(let data):
                Decoder.decodeUser(from: data)
                DispatchQueue.main.async { [unowned self] in
                    self.signUpView.finishLoading()
                    Router.presentMainView(from: self)
                }
            }
        }
    }
    
    private func performLogInWith(email: String, password: String) {
        requestManager.logInWith(email: email, password: password) {  [unowned self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async { [unowned self] in
                    self.signUpView.finishLoading()
                    AlertManager.presentSimpleAlert(self, title: C.oops, message: C.signUpErrorMessage)
                }
            case .success(let data):
                Decoder.decodeUser(from: data)
                DispatchQueue.main.async { [unowned self] in
                    self.signUpView.finishLoading()
                    Router.presentMainView(from: self)
                }
            }
        }
    }

}
// MARK: - Keyboard
extension SignUpViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        signUpView.showKeyboard(with: keyboardHeight)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if !continueTyping {
            signUpView.hideKeyboard()
        }
    }
}
// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let nextField = signUpView.viewWithTag(textField.tag + 1) {
            nextField.becomeFirstResponder()
        } else {
            continueTyping = false
        }
        return true
    }
    
}

// MARK: - SignUpViewDelegate
extension SignUpViewController: SignUpViewDelegate {
    
    func mainButtonDidPressedWith(nameText: String?, emailText: String, passwordText: String) {
        
        if emailText != "", passwordText != "" {
            if DataValidator.validateEmail(emailText) {
                if let name = nameText {
                    signUpView.startLoading()
                    // Sign Up
                    performSignUpWith(name: name, email: emailText, password: passwordText)
                } else {
                    signUpView.startLoading()
                    // Log In
                    performLogInWith(email: emailText, password: passwordText)
                }
            } else {
                AlertManager.presentSimpleAlert(self, title: C.oops, message: C.invalidEmailMessage)
            }
        } else {
            AlertManager.presentSimpleAlert(self, title: C.oops, message: C.blankFieldsMessage)
        }
    }
    
}
