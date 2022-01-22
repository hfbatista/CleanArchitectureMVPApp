//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Henrique Batista on 19/05/21.
//

import Foundation
import Alamofire
import Data

public final class AlamofireAdapter: HttpPostClientProtocol {
	private let session: Session
	
	public init(for session: Session = .default) {
		self.session = session
	}
	
	public func post(to url:URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
		self.session.request(url, method: .post, parameters: data?.toJSON(), encoding: JSONEncoding.default).responseData { responseData in
			guard let statusCode = responseData.response?.statusCode else { return completion(.failure(.noConnectivity)) }
			switch responseData.result {
				case .failure: completion(.failure(.noConnectivity))
				case .success(let receivedData):
					switch statusCode {
						case 204:
							completion(.success(nil))
						case 200...299:
							completion(.success(receivedData))
						case 401:
							completion(.failure(.unauthorized))
						case 403:
							completion(.failure(.forbidden))
						case 400...499:
							completion(.failure(.badRequest))
						case 500...599:
							completion(.failure(.serverError))
						default:
							completion(.failure(.noConnectivity))
					}
			}
		}
	}
}
