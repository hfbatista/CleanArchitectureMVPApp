//
//  CreateAccount.swift
//  Domain
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation

public protocol AuthenticationProtocol {
	typealias Result = Swift.Result<AccountModel, DomainError>
	func create(_ createAccountModel: AuthenticationModel, completion: @escaping (Result) ->  Void)
}

public struct AuthenticationModel: BaseModel {
	public var email				: String
	public var password				: String
	
	public init(email: String, password: String) {
		self.email					= email
		self.password				= password
	}
}
