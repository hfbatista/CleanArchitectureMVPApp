//
//  SignUpFactory.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import UI
import Presentation
import Validation
import Domain


class ControllerFactory {
	static func makeSignUp(createAccount: CreateAccount) -> SignUpViewController {
		let controller = SignUpViewController.instantiate()
		let emailValidatorAdapter = EmailValidatorAdapter()
		let presenter = SignUpPresenter(loadingView: WeakVarProxy(controller),
										alertView: WeakVarProxy(controller),
										emailValidator: emailValidatorAdapter,
										createAccount: createAccount)
		
		controller.signUp = presenter.signUp
		
		return controller
	}
}

