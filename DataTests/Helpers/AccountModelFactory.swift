//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Henrique Batista on 10/05/21.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
	return AccountModel(id: "1", name: "nome", email: "a@b.c", password: "123")
}