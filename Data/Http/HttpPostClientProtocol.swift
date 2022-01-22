//
//  HttpPostClient.swift
//  Data
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation

public protocol HttpPostClientProtocol {
	func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
