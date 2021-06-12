//
//  Storyboarded.swift
//  UI
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import UIKit

public protocol Storyboarded {
	static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
	public static func instantiate() -> Self {
		let vcName = String(describing: self)
		let sbName = vcName.components(separatedBy: "ViewController").first!
		let bundle = Bundle(for: Self.self)
		let sb = UIStoryboard(name: sbName, bundle: bundle)
		
		return sb.instantiateViewController(identifier: vcName) as! Self
	}
}
