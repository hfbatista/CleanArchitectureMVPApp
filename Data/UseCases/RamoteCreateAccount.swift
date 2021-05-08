//
//  RamoteCreateAccount.swift
//  Data
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation
import Domain

public final class RamoteCreateAccount {
	private let url: URL
	private let httpClient: HttpPostClient
	
	public init(url: URL, httpClient: HttpPostClient) {
		self.url = url
		self.httpClient = httpClient
	}
	
	public func create(_ createAccountModel: CreateAccountModel) {
		self.httpClient.post(to: self.url, with: createAccountModel.toData())
	}
}

