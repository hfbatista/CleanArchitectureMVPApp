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
		
		sut.create(self.makeCreateAccountModel()) { _ in }
		XCTAssertEqual(httpClientSpy.urls, [testURL])
    }
	
	func test_should_call_httpClient_with_correct_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let createAccountModel = self.makeCreateAccountModel()
		
		sut.create(createAccountModel) { _ in }
		XCTAssertEqual(httpClientSpy.data, createAccountModel.toData())
	}
	
	func test_should_complete_with_error_if_client_fails() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let exp = expectation(description: "waiting...")
		let expectedAccount = makeAccountModel()
		
		sut.create(self.makeCreateAccountModel()) { result in
			switch result {
				case .failure: XCTFail("Expected an success and reveived \(result) instead")
				case .success (let receivedAccount): XCTAssertEqual(receivedAccount, expectedAccount)
			}
			exp.fulfill()
		}
		httpClientSpy.completionWithData(expectedAccount.toData()!)
		wait(for: [exp], timeout: 1)
	}
	
	func test_should_complete_with_account_if_client_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let exp = expectation(description: "waiting...")
		
		sut.create(self.makeCreateAccountModel()) { result in
			switch result {
				case .failure(let error):(XCTAssertEqual(error, .unexpected))
				case .success: XCTFail("Expected an error and reveived \(result) instead")
			}
			exp.fulfill()
		}
		httpClientSpy.completionWithError(error: .noConnectivity)
		wait(for: [exp], timeout: 1)
	}
}

extension RemoteCreateAccountTests {
	func makeCreateAccountModel() -> CreateAccountModel {
		return CreateAccountModel(name: "nome", email: "a@b.c", password: "123", passwordConfirmation: "123")
	}
	
	func makeAccountModel() -> AccountModel {
		return AccountModel(id: "1", name: "nome", email: "a@b.c", password: "123")
	}
	
	func makeSut(with url: URL = URL(string: "https://any-url")!) -> (sut: RamoteCreateAccount, httpClientSpy: HttpClientSpy) {
		let httpClientSpy = HttpClientSpy()
		let sut = RamoteCreateAccount(url: url, httpClient: httpClientSpy)
		return (sut, httpClientSpy)
	}
	
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
}
