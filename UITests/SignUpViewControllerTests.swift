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
		let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
		let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
		sut.loadViewIfNeeded()
		XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
		
    }
	
	func test_sut_implements_loadingView_protocol() {
		let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
		let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
		XCTAssertNotNil(sut as LoadingView)
		
	}

}
