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
	
	override func viewDidLoad() {}
	
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


