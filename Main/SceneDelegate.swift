//
//  SceneDelegate.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		let httpCLient = makeAlamofireAdapter()
		let createAccount = makeRemoteCreateAccount(httpCLient: httpCLient)
		let signupController = makeSignupViewController(createAccount: createAccount)
		let nav = NavigationController(rootViewController: signupController)

		window?.rootViewController = nav
		window?.makeKeyAndVisible()
	}
}

