//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation
import Domain

public final class RemoteAuthentication {
	private let url: URL
	private let httpClient: HttpPostClientProtocol
	
	public init(url: URL, httpClient: HttpPostClientProtocol) {
		self.url = url
		self.httpClient = httpClient
	}
	
	public func auth(_ authenticationModel: AuthenticationModel, completion: @escaping (AuthenticationProtocol.Result) -> Void) {
		self.httpClient.post(to: self.url, with: authenticationModel.toData()) { _ in }
	}
}
