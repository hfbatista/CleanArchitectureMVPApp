//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Domain

public final class SignUpMapper {
	static func toCreateAccountModel(viewModel: SignUpViewModel) -> CreateAccountModel {
		return CreateAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
	}
}
