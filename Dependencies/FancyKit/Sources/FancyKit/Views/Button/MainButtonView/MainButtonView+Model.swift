//
//  MainButtonView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Style

extension MainButtonView {
  public enum Style {
    /// Стиль активной кнопки
    var enabledColors: [Color] {
      switch self {
      case .primary:
        return Constants.primaryEnabledColors
      case .secondary:
        return Constants.secondaryEnabledColors
      }
    }
    
    /// Стиль не активной кнопки
    var disabledColors: [Color] {
      switch self {
      case .primary:
        return Constants.primaryDisabledColors
      case .secondary:
        return Constants.secondaryDisabledColors
      }
    }
    
    /// Основной стиль
    case primary
    /// Вторичный стиль
    case secondary
  }
}

// MARK: - Constants

private enum Constants {
  static let primaryEnabledColors: [Color] = [
    Color.fancy.constant.azure,
    Color.fancy.constant.azure.opacity(0.8)
  ]
  static let primaryDisabledColors: [Color] = [
    Color.fancy.constant.azure.opacity(0.3),
    Color.fancy.constant.azure.opacity(0.2)
  ]
  
  static let secondaryEnabledColors: [Color] = [
    Color.fancy.constant.navy,
    Color.fancy.constant.navy.opacity(0.8)
  ]
  static let secondaryDisabledColors: [Color] = [
    Color.fancy.constant.navy.opacity(0.3),
    Color.fancy.constant.navy.opacity(0.2)
  ]
}
