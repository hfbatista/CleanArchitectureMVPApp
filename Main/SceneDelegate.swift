//
//  SceneDelegate.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let httpCLient = makeAlamofireAdapter()
		let createAccount = makeRemoteCreateAccount(httpCLient: httpCLient)
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = makeSignupViewController(createAccount: createAccount)
		window?.makeKeyAndVisible()
	}
}

