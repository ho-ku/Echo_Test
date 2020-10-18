//
//  SignUpView.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

protocol SignUpViewDelegate: class {
    func mainButtonDidPressedWith(nameText: String?, emailText: String, passwordText: String)
}

final class SignUpView: UIView {
    
    private enum State {
        case signUp
        case logIn
    }
    
    // MARK: - Properties
    private var currentState: State = .signUp {
        didSet {
            stateDidChange()
        }
    }
    weak var delegate: (SignUpViewDelegate & UITextFieldDelegate)? {
        didSet {
            setupDelegates()
        }
    }
    private var keyboardIsHidden = true
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - IBOutlets
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            nameTextField.autocorrectionType = .no
            nameTextField.tag = 2
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.autocorrectionType = .no
            emailTextField.tag = 3
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.autocorrectionType = .no
            passwordTextField.tag = 4
        }
    }
    @IBOutlet private weak var mainButton: UIButton!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.isHidden = true
        }
    }
    
    // MARK: - IBActions
    @IBAction func mainButtonPressed(sender: UIButton) {
        switch currentState {
        case .signUp:
            delegate?.mainButtonDidPressedWith(nameText: nameTextField.text, emailText: emailTextField.text ?? "", passwordText: passwordTextField.text ?? "")
        case .logIn:
            delegate?.mainButtonDidPressedWith(nameText: nil, emailText: emailTextField.text ?? "", passwordText: passwordTextField.text ?? "")
        }
    }
    @IBAction func bottomButtonPressed(sender: UIButton) {
        invertState()
    }
    
    // MARK: - Loading indicator
    func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func finishLoading() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: - Working with keyboard
    func showKeyboard(with height: CGFloat) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            keyboardHeight = height
            let diff = (40 + self.frame.height - keyboardHeight) - (mainButton.frame.height + mainButton.frame.origin.y)
            centerConstraint.constant -= diff > 0 ? diff : 0
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.layoutIfNeeded()
            }
        }
    }
    
    func hideKeyboard() {
        if !keyboardIsHidden {
            keyboardIsHidden = true
            let diff = (self.frame.height - keyboardHeight) - (mainButton.frame.height + mainButton.frame.origin.y)
            centerConstraint.constant += diff > 0 ? diff : 0
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setupDelegates() {
        nameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    // MARK: - Working with states
    private func invertState() {
        currentState = currentState == .signUp ? .logIn : .signUp
    }

    private func stateDidChange() {
        switch currentState {
        case .signUp:
            welcomeLabel.text = SignUpC.signUpWelcomeText
            nameTextField.isHidden = false
            bottomButton.setTitle(SignUpC.logIn, for: .normal)
            bottomLabel.text = SignUpC.signUpBottomText
            mainButton.setTitle(SignUpC.signUp, for: .normal)
        case .logIn:
            welcomeLabel.text = SignUpC.logInWelcomeText
            nameTextField.isHidden = true
            bottomButton.setTitle(SignUpC.signUp, for: .normal)
            bottomLabel.text = SignUpC.logInBottomText
            mainButton.setTitle(SignUpC.logIn, for: .normal)
        }
    }
    
}
