//
//  Enviroment.swift
//  Main
//
//  Created by Henrique Batista on 26/07/21.
//

import Foundation

final class Enviroment {
	enum EnviromentVariables: String {
		case apiBaseUrl = "API_BASE_URL"
	}
	
	static func variable(_ key: EnviromentVariables) -> String{
		return Bundle.main.infoDictionary![key.rawValue] as! String
	}
}
