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
import Infra
		
public final class SignUpComposer {
	public static func composeViewControllerWith(createAccount: CreateAccount) -> SignUpViewController {
		let controller = SignUpViewController.instantiate()
		let validationComposite = ValidationComposite(validations: makeValidations())
		let presenter = SignUpPresenter(loadingView: WeakVarProxy(controller),
										alertView: WeakVarProxy(controller),
										createAccount: createAccount,
										validation: validationComposite)
		
		controller.signUp = presenter.signUp
		
		return controller
	}
	
	public static func makeValidations() -> [ValidationProtocol] {
		return [
			RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
			RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
			EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: EmailValidatorAdapter()),
			RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
			RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar senha"),
			CompareFieldsValidation(fieldName: "password", fieldLabel: "Confirmar senha", fieldNameToCompare: "passwordConfirmation")
		]
	}
}
