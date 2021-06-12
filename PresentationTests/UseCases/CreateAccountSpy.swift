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
	var completion: ((Result<AccountModel, DomainError>) -> Void)?
	
	func create(_ createAccountModel: CreateAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
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
