//
//  InputView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Style

extension InputView {
  public enum Style: Equatable {
    /// Включен хелпер сверху
    var isTopHelper: Bool {
      switch self {
      case .topHelper: return true
      default: return false
      }
    }
    
    /// Слева подсказка
    case leftHelper(text: String)
    
    /// Сверху подсказка
    case topHelper(text: String)
    
    /// Без подсказок
    case none
  }
}
