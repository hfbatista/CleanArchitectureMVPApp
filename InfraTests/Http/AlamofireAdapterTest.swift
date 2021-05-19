//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Henrique Batista on 10/05/21.
//

import XCTest
import Alamofire
import Data
import Infra

class AlamofireAdapterTest: XCTestCase {
	
    func test_post_should_make_request_with_valid_url_and_method() throws {
		let url = makeURL()
		self.testRequest(for: url, data: makeValidData()) { request in
			XCTAssertEqual(url, request.url)
			XCTAssertEqual("POST", request.httpMethod)
			XCTAssertNotNil(request.httpBodyStream)
		}
	}
	
	func test_post_should_make_request_with_no_data() throws {
		self.testRequest(data: nil) { request in
			XCTAssertNil(request.httpBodyStream)
		}
	}
	
	func test_post_should_complete_with_error_when_request_completes_with_error() throws {
		expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
	}
	
	func test_post_should_complete_with_error_on_all_invalid_cases() throws {
		expectedResult(.failure(.noConnectivity), when: ( data: makeValidData(), response: makeURLResponse(),error: makeError()))
		expectedResult(.failure(.noConnectivity), when: ( data: makeValidData(), response: nil,error: makeError()))
		expectedResult(.failure(.noConnectivity), when: ( data: makeValidData(), response: nil, error: nil))
		expectedResult(.failure(.noConnectivity), when: ( data: nil, response: makeURLResponse(), error: makeError()))
		expectedResult(.failure(.noConnectivity), when: ( data: nil, response: makeURLResponse(),error: nil))
		expectedResult(.failure(.noConnectivity), when: ( data: nil, response: nil,error: nil))
	}
	
	func test_post_should_complete_with_data_when_request_completes_with_200() throws {
		expectedResult(.success(makeValidData()), when: (data: makeValidData(), response: makeURLResponse(), error: nil))
	}
	
	func test_post_should_complete_with_no_data_when_request_completes_with_204() throws {
		expectedResult(.success(nil), when: (data: makeValidData(), response: makeURLResponse(statusCode: 204), error: nil))
		expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeURLResponse(statusCode: 204), error: nil))
		expectedResult(.success(nil), when: (data: nil, response: makeURLResponse(statusCode: 204), error: nil))
	}
	
	func test_post_should_complete_with_error_when_request_completes_with_non_200() throws {
		expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeURLResponse(statusCode: 400), error: nil))
		expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeURLResponse(statusCode: 450), error: nil))
		expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeURLResponse(statusCode: 499), error: nil))
		expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeURLResponse(statusCode: 500), error: nil))
		expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeURLResponse(statusCode: 550), error: nil))
		expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeURLResponse(statusCode: 599), error: nil))
		expectedResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeURLResponse(statusCode: 401), error: nil))
		expectedResult(.failure(.forbidden), when: (data: makeValidData(), response: makeURLResponse(statusCode: 403), error: nil))
		expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeURLResponse(statusCode: 300), error: nil))
	}
}

extension AlamofireAdapterTest {
	func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
		let urlConfiguration = URLSessionConfiguration.default
		urlConfiguration.protocolClasses = [UrlProtocolStub.self]
		let session = Session(configuration: urlConfiguration)
		let sut = AlamofireAdapter(for: session)
		checkMemoryLeak(for: sut, file: file, line: line)
		return sut
	}
	
	func testRequest(for url: URL = makeURL(), data: Data?, action: @escaping (URLRequest) -> Void) {
		let sut = makeSUT()
		let exp = expectation(description: "Waiting")
		var request: URLRequest?
		sut.post(to: url, with: data){ _ in exp.fulfill()}
		UrlProtocolStub.observeRequest { request = $0}
		wait(for: [exp], timeout: 1)
		
		action(request!)
	}
	
	func expectedResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
		let sut = makeSUT()
		UrlProtocolStub.simulate(data: stub.data, error: stub.error, response: stub.response)
		let exp = expectation(description: "Waiting...")
		
		sut.post(to: makeURL(), with: makeValidData()) { receivedResult in
			switch (expectedResult, receivedResult) {
				case (.failure(let expectedError), .failure(let receivedError)):
					XCTAssertEqual(expectedError, receivedError, file: file, line: line)
					
				case (.success(let expectedData), .success(let receivedData)):
					XCTAssertEqual(expectedData, receivedData, file: file, line: line)
					
				default: XCTFail("Expected \(expectedResult) and got \(receivedResult) instead")
			}
			exp.fulfill()
		}
		
		wait(for: [exp], timeout: 1)
	}
}


