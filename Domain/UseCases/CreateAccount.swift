//
//  CreateAccount.swift
//  Domain
//
//  Created by Henrique Batista on 07/05/21.
//

import Foundation

public protocol CreateAccount {
	typealias Result = Swift.Result<AccountModel, DomainError>
	func create(_ createAccountModel: CreateAccountModel, completion: @escaping (Result) ->  Void)
}

public struct CreateAccountModel: BaseModel {
	public var name					: String
	public var email				: String
	public var password				: String
	public var passwordConfirmation	: String
	
	public init(name: String, email: String, password: String, passwordConfirmation: String) {
		self.name					= name
		self.email					= email
		self.password				= password
		self.passwordConfirmation	= passwordConfirmation
	}
}
