//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Henrique Batista on 08/05/21.
//

import Foundation

public extension Data {
	func toModel<T: Decodable>() -> T? {
		return try? JSONDecoder().decode(T.self, from: self)
	}
	
	func toJSON() -> [String: Any]? {
		return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
	}
}
