//
//  UITests.swift
//  UITests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import UIKit
import Presentation
@testable import UI


class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
		XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
	
	func test_sut_implements_loadingView_protocol() {
		XCTAssertNotNil(makeSut() as LoadingView)
		
	}
	
	func test_sut_implements_alertView_protocol() {
		XCTAssertNotNil(makeSut() as AlertView)
	}
	
	func test_saveButton_calls_signUp_on_tap() {
		var signUpViewModel: SignUpViewModel?
		let sut = makeSut(signUpSpy: { signUpViewModel = $0})
		
		let name = sut.nameTextField?.text
		let email = sut.emailTextField?.text
		let password = sut.passwordTextField?.text
		let passwordConfirmation = sut.confirmationTextField?.text
		
		sut.saveButton?.simulateTap()
		XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
	}
}

extension SignUpViewControllerTests {
	func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
		let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
		let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
		sut.signUp = signUpSpy
		sut.loadViewIfNeeded()
		
		return sut
	}
}

extension UIControl {
	func simulate(event: UIControl.Event) {
		allTargets.forEach { target in
			actions(forTarget: target, forControlEvent: event)?.forEach({ action in
				(target as NSObject).perform(Selector(action))
			})
		}
	}
	
	func simulateTap() {
		simulate(event: .touchUpInside)
	}
}
