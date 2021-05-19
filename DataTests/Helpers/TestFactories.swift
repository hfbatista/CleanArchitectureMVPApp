//
//  TestFactories.swift
//  DataTests
//
//  Created by Henrique Batista on 10/05/21.
//

import Foundation

func makeInvalidData() -> Data {
	return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
	return Data("{\"name\":\"Henrique\"}".utf8)
}

func makeURL() -> URL {
	return URL(string: "https://any-url")!
}

func makeError() -> Error {
	return NSError(domain: "any_error", code: 0)
}

func makeURLResponse(statusCode: Int = 200) -> HTTPURLResponse {
	return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
