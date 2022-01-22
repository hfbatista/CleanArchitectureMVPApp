//
//  UseCaseFactory.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Infra

func makeEmailValidatorAdapter() -> EmailValidatorAdapter {
	return EmailValidatorAdapter()
}
