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
		let testURL = self.makeURL()
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
	
	func test_should_complete_with_error_if_client_completes_with_error() throws {
		let (sut, httpClientSpy) = self.makeSut()
		expect(sut, completeWith: .failure(.unexpected)) {
			httpClientSpy.completionWithError(error: .noConnectivity)
		}
	}
	
	func test_should_complete_with_account_if_client_completes_with_valid_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let expectedAcount = makeAccountModel()
		expect(sut, completeWith: .success(expectedAcount)) {
			httpClientSpy.completionWithData(expectedAcount.toData()!)
		}
	}
	
	func test_should_complete_with_error_if_client_completes_with_invalid_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		expect(sut, completeWith: .failure(.invalidData)) {
			httpClientSpy.completionWithData(makeInvalidData())
		}
	}
	
	func test_should_not_complete_if_sut_has_been_deallocated() throws {
		let httpClientSpy = HttpClientSpy()
		var stu: RamoteCreateAccount? = RamoteCreateAccount(url: makeURL(), httpClient: httpClientSpy)
		var result: Result<AccountModel, DomainError>?
		
		stu?.create(makeCreateAccountModel()){ result = $0 }
		stu = nil
		httpClientSpy.completionWithError(error: .noConnectivity)
		XCTAssertNil(result)
	}
	
}

extension RemoteCreateAccountTests {
	func makeSut(with url: URL = URL(string: "https://any-url")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RamoteCreateAccount, httpClientSpy: HttpClientSpy) {
		let httpClientSpy = HttpClientSpy()
		let sut = RamoteCreateAccount(url: url, httpClient: httpClientSpy)
		self.checkMemoryLeak(for: sut, file: file, line: line)
		self.checkMemoryLeak(for: httpClientSpy, file: file, line: line)
		return (sut, httpClientSpy)
	}
	
	func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
		addTeardownBlock { [weak instance] in
			XCTAssertNil(instance, file: file, line: line)
		}
	}
	
	func expect(_ sut: RamoteCreateAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
		let exp = expectation(description: "waiting...")
		sut.create(self.makeCreateAccountModel()) { receivedResult in
			switch ( expectedResult, receivedResult ) {
				case (.failure(let expectedError), .failure(let receivedError)):
					(XCTAssertEqual(expectedError, receivedError, file: file, line: line))
					
				case (.success(let expectedAccount), .success(let receivedAccount)):
					XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
					
				default:
					XCTFail("Expected \(expectedResult) and reveived \(receivedResult) instead", file: file, line: line)
			}
			exp.fulfill()
		}
		action()
		wait(for: [exp], timeout: 1)
	}
	
	func makeInvalidData() -> Data {
		return Data("invalid_data".utf8)
	}
	
	func makeURL() -> URL {
		return URL(string: "https://any-url")!
	}
	
	func makeCreateAccountModel() -> CreateAccountModel {
		return CreateAccountModel(name: "nome", email: "a@b.c", password: "123", passwordConfirmation: "123")
	}
	
	func makeAccountModel() -> AccountModel {
		return AccountModel(id: "1", name: "nome", email: "a@b.c", password: "123")
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
