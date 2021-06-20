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
    
    private let validation: ValidationService

    private let dummyDatabase = [User(username: "paulomarinho", password: "password")]
    
    init(validation: ValidationService) {
           self.validation = validation
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           self.validation = ValidationService()
           super.init(coder: coder)
       }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
                    let username = try validation.validateUsername(usernameTextField.text)
                    let password = try validation.validatePassword(passwordTextField.text)
                    
                    // Login to database...
                    if let user = dummyDatabase.first(where: { user in
                        user.username == username && user.password == password
                    }) {
                        /*let storyBoard: UIStoryboard = UIStoryboard(name: "perfil", bundle: nil)
                        let perfilViewController = storyBoard.instantiateViewController(withIdentifier: "perfil") as! PerfilViewController
                        self.present(perfilViewController, animated: true, completion: nil)
 */
                        //presentAlert(with: "You successfully logged in as \(user.username)")
                        
                    } else {
                        throw LoginError.invalidCredentials
                    }
                    
                } catch {
                    present(error)
                }
    }
}

extension ViewController {
    enum LoginError: LocalizedError {
            case invalidCredentials
            
            var errorDescription: String? {
                switch self {
                case .invalidCredentials:
                    return "Login ou senha invalido."
                }
            }
        }
}
