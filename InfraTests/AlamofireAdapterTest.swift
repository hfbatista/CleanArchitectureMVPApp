//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Henrique Batista on 10/05/21.
//

import XCTest
import Alamofire

class AlamoFireAdapter {
	private let session: Session
	
	init(for session: Session = .default) {
		self.session = session
	}
	
	func post(to url:URL, with data: Data?) {
		let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
		self.session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
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
		sut.post(to: url, with: data)
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
	
	static func observeRequest(completion: @escaping (URLRequest) -> Void) {
		UrlProtocolStub.emit = completion
	}
	
	override open class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	override open func startLoading() {
		UrlProtocolStub.emit?(request)
	}
	override open func stopLoading(){
		
	}
}
