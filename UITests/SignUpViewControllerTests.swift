//
//  UITests.swift
//  UITests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import UIKit
@testable import UI


class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
		let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
		let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
		sut.loadViewIfNeeded()
		XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
		
    }

}
