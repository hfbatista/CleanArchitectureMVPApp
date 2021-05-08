//
//  CreateAccount.swift
//  Domain
//
//  Created by Henrique Batista on 07/05/21.
//

import Foundation

protocol CreateAccount {
	func create(createAccountModel: CreateAccountModel, completion: @escaping (Result<AccountModel, Error>) ->  Void)
}

struct CreateAccountModel {
	var name: String
	var email: String
	var password: String
	var passwordConfirmation: String
}
