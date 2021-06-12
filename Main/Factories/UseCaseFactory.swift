//
//  UseCaseFactory.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
	static func makeRemoteCreateAccount() -> CreateAccount {
		let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
		let alamofireAdapter = AlamofireAdapter()
		return RamoteCreateAccount(url: url, httpClient: alamofireAdapter)
	}
}
