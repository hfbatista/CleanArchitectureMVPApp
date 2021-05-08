//
//  BaseModel .swift
//  Domain
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation

public protocol BaseModel: Encodable {}

public extension BaseModel {
	func toData() -> Data? {
		return try? JSONEncoder().encode(self)
	}
}
