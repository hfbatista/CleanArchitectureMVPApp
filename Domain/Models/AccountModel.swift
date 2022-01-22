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


//private class Testeteete {
//	var dictionary:[LayoutManager : Any] = [:]
//	var model: ResponseModel = makeAccountModel()
//
//	func tesetses() {
//		for i in model.content {
//			dictionary[LayoutManager.init(rawValue: i.key) ?? .none] = i.value
//		}
//
//		var index = 0
//
//		if model.content.indices.contains(index) {
//			model.content[index].key
//		}
//
//		let buttonTitle = (dictionary[.button] as? String) ?? ""
//	}
//
//}
//
//public struct ResponseModel: Codable {
//	public var content: [AccountModelContent] = []
//}
//
//public struct ResponseModelContent: Codable {
//	public let key: String
//	public let value: String
//}
//
//
//public enum LayoutManager: String {
//	case button = "bi-modal-button"
//	case title = "bi-modal-title"
//	case subTitle = "bi-modal-subtitle"
//	case none = ""
//}
