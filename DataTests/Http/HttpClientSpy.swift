//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Henrique Batista on 10/05/21.
//

import Foundation
import Data

class HttpClientSpy: HttpPostClient {
	var urls = [URL]()
	var data: Data?
	var completion: ((Result<Data, HttpError>) -> Void)?
	
	func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
		self.urls.append(url)
		self.data = data
		self.completion = completion
	}
	
	func completionWithError(error: HttpError) {
		self.completion?(.failure(error))
	}
	
	func completionWithData(_ data: Data) {
		self.completion?(.success(data))
	}
}
