//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Henrique Batista on 19/05/21.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTest: XCTestCase {
    func test_add_account() throws {
		let alamofireAdapter = AlamofireAdapter()
		let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
		let sut = RamoteCreateAccount(url: url, httpClient: alamofireAdapter)
		let exp = expectation(description: "Waiting...")
		let createAcountModel = CreateAccountModel(name: "Rodrigo Manguinho", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
 
		sut.create(createAcountModel) { result in
			switch result {
				case .failure(let error):
					XCTFail("Expected success and got \(result) instead, with error: \(error)")
				case .success(let account):
					XCTAssertNotNil(account.accessToken)
			}
			exp.fulfill()
		}

		wait(for: [exp], timeout: 10)
		
		let exp2 = expectation(description: "Waiting...")
		sut.create(createAcountModel) { result in
			switch result {
				case .failure(let error) where error == .emailInUse:
					XCTAssertNotNil(error)
				default:
					XCTFail("Expected failure and got \(result) instead")
			}
			exp2.fulfill()
		}
		
		wait(for: [exp2], timeout: 10)
    }
}
