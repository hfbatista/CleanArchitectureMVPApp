//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Henrique Batista on 20/05/21.
//

import Foundation
import Domain

public final class SignUpPresenter {
	private let alertView: AlertView
	private let createAccount: CreateAccount
	private let loadingView: LoadingView
	private let validation: ValidationProtocol
	
	public init(loadingView: LoadingView, alertView: AlertView, createAccount: CreateAccount, validation: ValidationProtocol) {
		self.alertView = alertView
		self.createAccount = createAccount
		self.loadingView = loadingView
		self.validation = validation
	}
	
	public func signUp(viewModel: SignUpViewModel) {
		if let message = self.validation.validate(data: viewModel.toJSON()) {
			self.alertView.showMessage(viewModel: AlertViewModel(title:  "Falha na validação", message: message))
		} else {
			self.loadingView.display(viewModel: LoadingViewModel(isLoading: true))
			self.createAccount.create(viewModel.toCreateAccountModel()) { [weak self] result in
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
					
					switch result {
						case .failure (let error):
							var erroMessage = ""
							switch error {
								case .emailInUse:
									erroMessage = "Esse email já está em uso!"
								default:
									erroMessage = "Algo inesperado aconteceu, tente novamenete em alguns instantes"
							}
							
							self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: erroMessage))
							
						case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta Criada com sucesso."))
					}
				}
			}
		}
	}
}
