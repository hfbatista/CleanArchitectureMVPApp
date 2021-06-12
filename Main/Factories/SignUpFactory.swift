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
import Data
import Infra

class SignUpFactory {
	static func makeController() -> SignUpViewController {
		let controller = SignUpViewController.instantiate()
		let emailValidatorAdapter = EmailValidatorAdapter()
		let url = URL(string: "")!
		let alamofireAdapter = AlamofireAdapter()
		let remoteCreateAccount = RamoteCreateAccount(url: url, httpClient: alamofireAdapter)
		let presenter = SignUpPresenter(loadingView: controller, alertView: controller, emailValidator: emailValidatorAdapter, createAccount: remoteCreateAccount)
		
		controller.signUp = presenter.signUp
		
		return controller
	}
}
