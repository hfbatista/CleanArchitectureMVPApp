//
//  SignUpViewController.swift
//  UI
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmationTextField: UITextField!
	
	
	var signUp: ((SignUpViewModel) -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	private func configure() {
		saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
	}
	
	@objc private func saveButtonTapped() {
		let viewModel = SignUpViewModel(name: nameTextField?.text,
										email: emailTextField?.text,
										password: passwordTextField?.text,
										passwordConfirmation: confirmationTextField?.text)
		signUp?(viewModel)
	}
	
}

extension SignUpViewController: LoadingView {
	func display(viewModel: LoadingViewModel) {
		if viewModel.isLoading {
			self.loadingIndicator?.startAnimating()
		} else {
			self.loadingIndicator?.stopAnimating()
		}
	}
}

extension SignUpViewController: AlertView {
	func showMessage(viewModel: AlertViewModel) {
		let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		
		present(alert, animated: true)
	}
}

