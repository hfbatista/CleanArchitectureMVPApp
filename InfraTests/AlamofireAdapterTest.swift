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
	
	func post(to url:URL) {
		self.session.request(url).resume()
	}
}

class AlamofireAdapterTest: XCTestCase {
	
    func test_() throws {
		let url = makeURL()
		let urlConfiguration = URLSessionConfiguration.default
		urlConfiguration.protocolClasses = [UrlProtocolStub.self]
		let session = Session(configuration: urlConfiguration)
		let sut = AlamoFireAdapter(for: session)
		sut.post(to: url)
		let exp = expectation(description: "Waiting")
		UrlProtocolStub.observeRequest { request in
			XCTAssertEqual(url, request.url)
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
