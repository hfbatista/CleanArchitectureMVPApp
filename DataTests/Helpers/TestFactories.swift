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

func makeURL() -> URL {
	return URL(string: "https://any-url")!
}
