//
//  PasscodeFieldView+Model.swift
//
//
//  Created by Vitalii Sosin on 15.12.2023.
//

import SwiftUI
import FancyStyle

// MARK: - Model

extension PasscodeFieldView {
  public enum PasscodeState {
    /// Цвет исходя из состаяния
    var color: Color {
      switch self {
      case .failure:
        return .fancy.constant.ruby
      case .success:
        return .fancy.constant.lime
      case .standart:
        return .fancy.constant.azure
      }
    }
    
    /// Ошибка
    case failure
    /// Успех
    case success
    /// По умолчанию
    case standart
  }
}
