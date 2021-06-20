//
//  ValidationService.swift
//  TestesIOS
//
//  Created by paulo marinho on 20/06/21.
//  Copyright © 2021 Kilo Loco. All rights reserved.
//

import Foundation

struct ValidationService {
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidValue }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard password.count >= 8 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        return password
    }
}
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
