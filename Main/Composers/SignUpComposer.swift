//
//  SignUpComposer.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Domain
import UI
		
public final class SignUpComposer {
	public static func composeViewControllerWith(createAccount: CreateAccount) -> SignUpViewController {
		return ControllerFactory.makeSignUp(createAccount: createAccount)
	}
}
