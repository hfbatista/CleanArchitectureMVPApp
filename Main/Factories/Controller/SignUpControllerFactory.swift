//
//  SignUpComposer.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeSignupViewController(createAccount: CreateAccount) -> SignUpViewController {
	let controller = SignUpViewController.instantiate()
	let validationComposite = ValidationComposite(validations: makeSignupValidations())
	let presenter = SignUpPresenter(loadingView: WeakVarProxy(controller),
									alertView: WeakVarProxy(controller),
									createAccount: createAccount,
									validation: validationComposite)
	
	controller.signUp = presenter.signUp
	
	return controller
}

public func makeSignupValidations() -> [ValidationProtocol] {
	return [
		RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
		RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
		EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: makeEmailValidatorAdapter()),
		RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
		RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar senha"),
		CompareFieldsValidation(fieldName: "password", fieldLabel: "Confirmar senha", fieldNameToCompare: "passwordConfirmation")
	]
}
