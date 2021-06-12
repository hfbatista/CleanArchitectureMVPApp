//
//  TestsExtensions.swift
//  UITests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import UIKit

extension UIControl {
	func simulate(event: UIControl.Event) {
		allTargets.forEach { target in
			actions(forTarget: target, forControlEvent: event)?.forEach({ action in
				(target as NSObject).perform(Selector(action))
			})
		}
	}
	
	func simulateTap() {
		simulate(event: .touchUpInside)
	}
}
