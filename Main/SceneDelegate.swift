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
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = ControllerFactory.makeSignUp(createAccount: UseCaseFactory.makeRemoteCreateAccount())
		window?.makeKeyAndVisible()
	}
}

