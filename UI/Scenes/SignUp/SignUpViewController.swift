//
//  SignUpViewController.swift
//  UI
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController, Storyboarded {
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmationTextField: UITextField!
	
	
	public var signUp: ((SignUpViewModel) -> Void)?
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	private func configure() {
		title = "4Dev"
		saveButton?.layer.cornerRadius = 5
		saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
		hideKeyBoardOnTap()
	}
	
	@objc private func saveButtonTapped() {
		signUp?(SignUpViewModel(name: nameTextField?.text,
								email: emailTextField?.text,
								password: passwordTextField?.text,
								passwordConfirmation: confirmationTextField?.text))
	}
	
}

extension SignUpViewController: LoadingView {
	public func display(viewModel: LoadingViewModel) {
		if viewModel.isLoading {
			view.isUserInteractionEnabled = false
			self.loadingIndicator?.startAnimating()
		} else {
			view.isUserInteractionEnabled = true
			self.loadingIndicator?.stopAnimating()
		}
	}
}

extension SignUpViewController: AlertView {
	public func showMessage(viewModel: AlertViewModel) {
		let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		
		present(alert, animated: true)
	}
}

