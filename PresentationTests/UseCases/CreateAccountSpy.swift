//
//  CreateAccountSpy.swift
//  PresentationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Domain

class CreateAccountSpy: CreateAccount {
	var createAccountModel: CreateAccountModel?
	var completion: ((CreateAccount.Result) -> Void)?
	
	func create(_ createAccountModel: CreateAccountModel, completion: @escaping (CreateAccount.Result) -> Void) {
		self.createAccountModel = createAccountModel
		self.completion = completion
	}
	
	func completeWithError(_ error: DomainError) {
		self.completion?(.failure(error))
	}
	
	func completeWithAccount(_ account: AccountModel) {
		completion?(.success(account))
	}
}
