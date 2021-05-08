//
//  DataTests.swift
//  DataTests
//
//  Created by Henrique Batista on 07/05/21.
//

import XCTest
import Domain

class RamoteCreateAccount {
	private let url: URL
	private let httpClient: HttpPostClient
	
	init(url: URL, httpClient: HttpPostClient) {
		self.url = url
		self.httpClient = httpClient
	}
	
	func create(_ createAccountModel: CreateAccountModel) {
		let data = try? JSONEncoder().encode(createAccountModel)
		self.httpClient.post(to: self.url, with: data )
	}
}

protocol HttpPostClient {
	func post(to url: URL, with data: Data?)
}

class RemoteCreateAccountTests: XCTestCase {

    func test_should_call_httpClient_with_correct_url() throws {
		let testURL = URL(string: "https://any-url")!
		let (sut, httpClientSpy) = self.makeSut(with: testURL)
		
		sut.create(self.makeCreateAccountModel())
		XCTAssertEqual(httpClientSpy.url, testURL)
    }
	
	func test_should_call_httpClient_with_correct_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let createAccountModel = self.makeCreateAccountModel()
		
		sut.create(createAccountModel)
		let data = try? JSONEncoder().encode(createAccountModel)
		
		XCTAssertEqual(httpClientSpy.data, data)
	}
}

extension RemoteCreateAccountTests {
	func makeCreateAccountModel() -> CreateAccountModel {
		return CreateAccountModel(name: "nome", email: "a@b.c", password: "123", passwordConfirmation: "123")
	}
	
	func makeSut(with url: URL = URL(string: "https://any-url")!) -> (sut: RamoteCreateAccount, httpClientSpy: HttpClientSpy) {
		let httpClientSpy = HttpClientSpy()
		let sut = RamoteCreateAccount(url: url, httpClient: httpClientSpy)
		return (sut, httpClientSpy)
	}
	
	class HttpClientSpy: HttpPostClient {
		var url		: URL?
		var data	: Data?
		
		func post(to url: URL, with data: Data?) {
			self.url = url
			self.data = data
		}
	}
}
