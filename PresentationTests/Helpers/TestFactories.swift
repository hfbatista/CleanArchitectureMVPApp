//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "123@teste.com", password: String? = "secret", passwordConfirmation: String? = "secret") -> SignUpViewModel {
	return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeAlertViewModel(fieldName: String) -> AlertViewModel {
	return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório!")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
	return AlertViewModel(title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
	return AlertViewModel(title: "Sucesso", message: message)
}
