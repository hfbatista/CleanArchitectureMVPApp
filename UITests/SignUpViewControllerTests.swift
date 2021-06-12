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
}

extension SignUpViewControllerTests {
	func makeSut() -> SignUpViewController {
		let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
		let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
		sut.loadViewIfNeeded()
		
		return sut
	}
}
