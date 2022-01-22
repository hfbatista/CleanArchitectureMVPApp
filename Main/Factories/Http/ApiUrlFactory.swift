//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation

func makeApiUrl(endpoint: String) -> URL {
	return URL(string: "\(Enviroment.variable(.apiBaseUrl) + endpoint)")!
}
