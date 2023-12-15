//
//  RoundButtonView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI
import FancyStyle

// MARK: - Style

extension RoundButtonView {
  public enum Style {
    var text: String {
      switch self {
      case let .custom(_, text):
        return text
      case let .copy(text):
        return text
      }
    }
    
    var image: UIImage? {
      switch self {
      case let .custom(imageData, _):
        guard let imageData else {
          return nil
        }
        return UIImage(data: imageData)?.recolorImage(with: .fancy.constant.ghost)
      case .copy:
        return UIImage(systemName: "rectangle.on.rectangle")?.recolorImage(with: .fancy.constant.ghost)
      }
    }
    
    /// Пользовательские настройки
    case custom(imageData: Data?, text: String)
    /// Копировать
    case copy(text: String)
  }
}
