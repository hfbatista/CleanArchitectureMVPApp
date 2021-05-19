//
//  RamoteCreateAccount.swift
//  Data
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation
import Domain

public final class RamoteCreateAccount: CreateAccount {
	private let url: URL
	private let httpClient: HttpPostClient
	
	public init(url: URL, httpClient: HttpPostClient) {
		self.url = url
		self.httpClient = httpClient
	}
	
	public func create(_ createAccountModel: CreateAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
		self.httpClient.post(to: self.url, with: createAccountModel.toData()) { [ weak self ] result in
			guard self != nil else { return }
			switch result {
				case .success (let data):
					if let model: AccountModel = data?.toModel() {
						completion(.success(model))
					} else {
						completion(.failure(.invalidData))
					}
				case .failure: completion(.failure(.unexpected))
			}
		}
	}
}
