//
//  DataTests.swift
//  DataTests
//
//  Created by Henrique Batista on 07/05/21.
//

import XCTest
import Domain
import Data

class RemoteCreateAccountTests: XCTestCase {

    func test_should_call_httpClient_with_correct_url() throws {
		let testURL = URL(string: "https://any-url")!
		let (sut, httpClientSpy) = self.makeSut(with: testURL)
		
		sut.create(self.makeCreateAccountModel())
		XCTAssertEqual(httpClientSpy.urls, [testURL])
    }
	
	func test_should_call_httpClient_with_correct_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let createAccountModel = self.makeCreateAccountModel()
		
		sut.create(createAccountModel)
		XCTAssertEqual(httpClientSpy.data, createAccountModel.toData())
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
		var urls = [URL]()
		var data: Data?
		
		func post(to url: URL, with data: Data?) {
			self.urls.append(url)
			self.data = data
		}
	}
}
