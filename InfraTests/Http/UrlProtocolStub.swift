//
//  UrlProtocolStub.swift
//  InfraTests
//
//  Created by Henrique Batista on 19/05/21.
//

import Foundation

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
