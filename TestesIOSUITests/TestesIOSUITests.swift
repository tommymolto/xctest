//
//  TestesIOSUITests.swift
//  TestesIOSUITests
//
//  Created by Paulo Moreira Marinho on 22/06/21.
//  Copyright © 2021 Santander. All rights reserved.
//

import XCTest

class TestesIOSUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
   }

    override func tearDown() {}

    
    func testaSenhaPequena() throws{
        do{
            try self.validaLogin(usuario: "paulomarinho", senha: "1", error: ValidationError.passwordTooShort)
        }catch{
            print(error)
        }
    }
    func testaSenhaGrande() throws{
        do{
            try self.validaLogin(usuario: "paulomarinho", senha: "minhasenhaemuitograndedeverdade", error: ValidationError.passwordTooShort)
        }catch{
            print(error)
        }
    }
    func testaLoginPequeno() throws{
        do{
            let app = XCUIApplication()
            app.launch()
            try self.validaLogin(usuario: "1", senha: "12234234", error: ValidationError.usernameTooShort)
            let screenshot = app.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.name = "My Great Screenshot"
            attachment.lifetime = .keepAlways
            add(attachment)
        }catch{
            print(error)
        }
    }
    
    func testaNavegacao() throws {
        let usuario = "paulomarinho"
        let senha = "password"
        let app = XCUIApplication()
        app.launch()
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.exists)
        usernameField.tap()
        usernameField.typeText(usuario)

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)

        passwordTextField.doubleTap()
        passwordTextField.typeText(senha)
        app.buttons["Login"].tap()
        let texto = app.textViews["nomePerfil"]
        
        XCTAssertTrue(texto.value as? String == "Ola meu povo")
        
    }
    
    func validaLogin( usuario: String,  senha: String,  error : ValidationError) throws {
        let app = XCUIApplication()
        app.launch()

        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.exists)
        usernameField.tap()
        usernameField.typeText(usuario)

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(usernameField.exists)

        passwordTextField.tap()
        passwordTextField.typeText(senha)
        app.buttons["Login"].tap()
        let erro = error.errorDescription!
        //let elementsQuery = app.alerts[erro].firstMatch
        let elementsQuery = app.alerts.scrollViews.otherElements.staticTexts[erro].firstMatch
        XCTAssertTrue(elementsQuery.exists)
        
    }
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
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
