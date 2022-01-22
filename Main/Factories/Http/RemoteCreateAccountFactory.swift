//
//  UseCaseFactory.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Data
import Domain

func makeRemoteCreateAccount(httpCLient: HttpPostClientProtocol) -> CreateAccount {
	let ramoteCreateAccount = RamoteCreateAccount(url: makeApiUrl(endpoint: "signup"), httpClient: httpCLient)
	return MainDispatchQueueDecorator(ramoteCreateAccount)
}
