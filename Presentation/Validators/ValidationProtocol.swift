//
//  ValidationProtocol.swift
//  Presentation
//
//  Created by Henrique Batista on 13/08/21.
//

import Foundation

public protocol ValidationProtocol {
	func validate(data: [String: Any]?) -> String?
}
