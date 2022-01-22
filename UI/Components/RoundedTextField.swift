//
//  RoundedTextField.swift
//  UI
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation
import UIKit

class RoundedTextField: UITextField {
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		layer.borderColor = Color.primaryLight.cgColor
		layer.cornerRadius = 5
		layer.borderWidth = 1
	}
}
