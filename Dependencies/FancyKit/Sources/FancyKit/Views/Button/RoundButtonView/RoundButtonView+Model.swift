//
//  RoundButtonView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI
import FancyStyle

// MARK: - Model

extension RoundButtonView {
  public struct Model {
    public let style: Style
    @Binding public var isEnabled: Bool
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания овальной кнопки
    /// - Parameters:
    ///   - style: Стиль кнопки
    ///   - isEnabled: Кнопка включена
    ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
    public init(style: RoundButtonView.Style,
                isEnabled: Binding<Bool> = .constant(true),
                action: @escaping () -> Void) {
      self.style = style
      self._isEnabled = isEnabled
      self.action = action
    }
  }
}

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
      case let .custom(image, _):
        guard let image else {
          return nil
        }
        return UIImage(data: image)?.recolorImage(with: .fancy.constant.ghost)
      case .copy:
        return UIImage(systemName: "rectangle.on.rectangle")?.recolorImage(with: .fancy.constant.ghost)
      }
    }
    
    /// Пользовательские настройки
    case custom(image: Data?, text: String)
    /// Копировать
    case copy(text: String)
  }
}
