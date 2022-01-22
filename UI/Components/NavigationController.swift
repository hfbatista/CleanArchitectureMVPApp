//
//  NavigationController.swift
//  UI
//
//  Created by Henrique Batista on 22/01/22.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
	public override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	public override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}
	
	private func setup() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithDefaultBackground()
		appearance.backgroundColor = Color.primaryDark
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
	}
}
