//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Henrique Batista on 22/01/22.
//

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
	
	func test_should_call_httpClient_with_correct_url() throws {
		let testURL = makeURL()
		let (sut, httpClientSpy) = self.makeSut(with: testURL)
		
		sut.auth(makeAuthenticationModel()) { _ in }
		XCTAssertEqual(httpClientSpy.urls, [testURL])
	}
	
	func test_should_call_httpClient_with_correct_data() throws {
		let (sut, httpClientSpy) = self.makeSut()
		let authenticationModel = makeAuthenticationModel()
		
		sut.auth(authenticationModel) { _ in }
		XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
	}
}

extension RemoteAuthenticationTests {
	func makeSut(with url: URL = URL(string: "https://any-url")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
		let httpClientSpy = HttpClientSpy()
		let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
		self.checkMemoryLeak(for: sut, file: file, line: line)
		self.checkMemoryLeak(for: httpClientSpy, file: file, line: line)
		return (sut, httpClientSpy)
	}
	
//	func expect(_ sut: RamoteCreateAccount, completeWith expectedResult: CreateAccount.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
//		let exp = expectation(description: "waiting...")
//		sut.create(makeCreateAccountModel()) { receivedResult in
//			switch ( expectedResult, receivedResult ) {
//				case (.failure(let expectedError), .failure(let receivedError)):
//					(XCTAssertEqual(expectedError, receivedError, file: file, line: line))
//
//				case (.success(let expectedAccount), .success(let receivedAccount)):
//					XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
//
//				default:
//					XCTFail("Expected \(expectedResult) and reveived \(receivedResult) instead", file: file, line: line)
//			}
//			exp.fulfill()
//		}
//		action()
//		wait(for: [exp], timeout: 1)
//	}
}
