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
	
	var signUp: ((SignUpViewModel) -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	private func configure() {
		saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
	}
	
	@objc private func saveButtonTapped() {
		signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
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
	func showMessage(viewModel: AlertViewModel) {}
}

