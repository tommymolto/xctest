//
//  ViewController.swift
//  Testes IOS
//
//  Created by Paulo Marinho on 17/6/21.
//  Copyright © 2021 Paulo Marinho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyDatabase = [User(username: "kilo loco", password: "password1")]
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
            guard
                let username = usernameTextField.text,
                let password = passwordTextField.text
                else { throw ValidationError.invalidValue }
            
            guard username.count > 3 else { throw ValidationError.usernameTooShort }
            guard username.count < 20 else { throw ValidationError.usernameTooLong }
            guard password.count >= 8 else { throw ValidationError.passwordTooShort }
            guard password.count < 20 else { throw ValidationError.passwordTooLong }
            
            
            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == user.password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
                
            } else {
                throw LoginError.invalidCredentials
            }
            
        } catch {
            present(error)
        }
    }
}

extension ViewController {
    enum ValidationError: LocalizedError {
        case invalidValue
        case passwordTooLong
        case passwordTooShort
        case usernameTooLong
        case usernameTooShort
        
        var errorDescription: String? {
            switch self {
            case .invalidValue:
                return "Voce entrou com um valor invalido."
            case .passwordTooLong:
                return "Sua senha é muito grande."
            case .passwordTooShort:
                return "Sua senha é muito pequena."
            case .usernameTooLong:
                return "Seu usuário é muito grande."
            case .usernameTooShort:
                return "Seu usuário é muito pequeno."
            }
        }
    }
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Login incorreto, tente de novo."
            }
        }
    }
}
