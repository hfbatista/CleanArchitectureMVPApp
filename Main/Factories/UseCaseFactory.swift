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
	private static let httpClient = AlamofireAdapter()
	private static let apiBaseUrl = Enviroment.variable(.apiBaseUrl)
	
	private static func makeUrl(endpoint: String) -> URL {
		return URL(string: "\(apiBaseUrl + endpoint)")!
	}
	
	static func makeRemoteCreateAccount() -> CreateAccount {
		let ramoteCreateAccount = RamoteCreateAccount(url: makeUrl(endpoint: "signup"), httpClient: httpClient)
		return MainDispatchQueueDecorator(ramoteCreateAccount)
	}
}
