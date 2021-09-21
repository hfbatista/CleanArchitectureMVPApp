//
//  AccountModel.swift
//  Domain
//
//  Created by Henrique Batista on 07/05/21.
//

import Foundation

public struct AccountModel: BaseModel {
	public var accessToken: String
	
	public init(accessToken: String) {
		self.accessToken = accessToken
	}
}
