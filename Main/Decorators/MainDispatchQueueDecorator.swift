//
//  MainDispatchQueueDecorator.swift
//  Main
//
//  Created by Henrique Batista on 31/07/21.
//

import Foundation
import Domain

public final class MainDispatchQueueDecorator<T> {
	private let instance: T
	
	public init(_ instance: T) {
		self.instance = instance
	}
	
	func dispatch(completion: @escaping () -> Void) {
		guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion)}
		completion()
	}
}

extension MainDispatchQueueDecorator: CreateAccount where T: CreateAccount{
	public func create(_ createAccountModel: CreateAccountModel,
					     completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
		self.instance.create(createAccountModel) {[weak self] result in
			self?.dispatch { completion(result) }
		}
	}
}
