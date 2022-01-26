//
//  AuthenticationModelFactory.swift
//  DataTests
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation
import Domain

func makeAuthenticationModel() -> AuthenticationModel {
	return AuthenticationModel(email: "123@teste.com", password: "secret")
}
