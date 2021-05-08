//
//  DataTests.swift
//  DataTests
//
//  Created by Henrique Batista on 07/05/21.
//

import XCTest

class RamoteCreateAccount {
	private let url: URL
	private let httpClient: HttpPostClient
	
	init(url: URL, httpClient: HttpPostClient) {
		self.url = url
		self.httpClient = httpClient
	}
	
	func create() {
		self.httpClient.post(url: self.url)
	}
}

protocol HttpPostClient {
	func post(url: URL)
}

class RemoteCreateAccountTests: XCTestCase {

    func testExample() throws {
		let url = URL(string: "https://any-url")!
		let httpClientSpy = HttpClientSpy()
		let sut = RamoteCreateAccount(url: url, httpClient: httpClientSpy)
		
		sut.create()
		XCTAssertEqual(httpClientSpy.url, url)
		
    }
	
	class HttpClientSpy: HttpPostClient {
		var url: URL?
		
		func post(url: URL) {
			self.url = url
		}
	}

}
