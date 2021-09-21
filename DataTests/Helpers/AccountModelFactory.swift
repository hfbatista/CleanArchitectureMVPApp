//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Henrique Batista on 10/05/21.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
	return AccountModel(accessToken: "1")
}

func makeCreateAccountModel() -> CreateAccountModel {
	return CreateAccountModel(name: "any_name", email: "123@teste.com", password: "secret", passwordConfirmation:  "secret")
}
