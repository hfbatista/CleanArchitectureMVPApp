//
//  BaseModel .swift
//  Domain
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation

public protocol BaseModel: Codable, Equatable {}

public extension BaseModel {
	func toData() -> Data? {
		return try? JSONEncoder().encode(self)
	}
	
	func toJSON() -> [String: Any]? {
		guard let data =  self.toData() else { return nil }
		return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
	}
}
