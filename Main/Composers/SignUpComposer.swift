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
		
public final class SignUpComposer {
	public static func composeViewControllerWith(createAccount: CreateAccount) -> SignUpViewController {
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
