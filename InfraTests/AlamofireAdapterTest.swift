//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Henrique Batista on 10/05/21.
//

import XCTest
import Alamofire
import Data

class AlamoFireAdapter {
	private let session: Session
	
	init(for session: Session = .default) {
		self.session = session
	}
	
	func post(to url:URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
		self.session.request(url, method: .post, parameters: data?.toJSON(), encoding: JSONEncoding.default).responseData { responseData in
			switch responseData.result {
				case .failure: completion(.failure(.noConnectivity))
				case .success: break
			}
		}
	}
}

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
		let sut = makeSUT()
		UrlProtocolStub.simulate(data: nil, error: makeError(), response: nil)
		let exp = expectation(description: "Waiting...")
		sut.post(to: makeURL(), with: makeValidData()) { result in
			switch result {
				case .failure(let error): XCTAssertEqual(error, .noConnectivity)
				case .success: XCTFail("Expected ERROR and got \(result) instead")
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1)
	}
}

extension AlamofireAdapterTest {
	func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> AlamoFireAdapter {
		let urlConfiguration = URLSessionConfiguration.default
		urlConfiguration.protocolClasses = [UrlProtocolStub.self]
		let session = Session(configuration: urlConfiguration)
		let sut = AlamoFireAdapter(for: session)
		checkMemoryLeak(for: sut, file: file, line: line)
		return sut
	}
	
	func testRequest(for url: URL = makeURL(), data: Data?, action: @escaping (URLRequest) -> Void) {
		let sut = makeSUT()
		sut.post(to: url, with: data){ _ in }
		let exp = expectation(description: "Waiting")
		UrlProtocolStub.observeRequest { request in
			action(request)
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1)
	}
}

class UrlProtocolStub: URLProtocol {
	static var emit: ((URLRequest) -> Void)?
	static var data: Data?
	static var error: Error?
	static var response: HTTPURLResponse?
	
	static func observeRequest(completion: @escaping (URLRequest) -> Void) {
		UrlProtocolStub.emit = completion
	}
	
	static func simulate(data: Data?, error: Error?, response: HTTPURLResponse?) {
		UrlProtocolStub.data = data
		UrlProtocolStub.error = error
		UrlProtocolStub.response = response
	}
	
	override open class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	override open func startLoading() {
		UrlProtocolStub.emit?(request)
		if let data = UrlProtocolStub.data {
			client?.urlProtocol(self, didLoad: data)
		}
		if let error = UrlProtocolStub.error {
			client?.urlProtocol(self, didFailWithError: error)
		}
		if let response = UrlProtocolStub.response {
			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
		}
		
		client?.urlProtocolDidFinishLoading(self)
	}
	override open func stopLoading(){
		
	}
}
