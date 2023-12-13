//
//  CircleButtonView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import Foundation

// MARK: - Model

extension CircleButtonView {
  public struct Model {
    public var isEnabled: Bool
    public let text: String?
    public let style: CircleButtonView.Style
    public let type: CircleButtonView.ButtonType
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модели
    /// - Parameters:
    ///   - isEnabled: Кнопка включена
    ///   - text: Текст, который будет отображаться под кнопкой
    ///   - style: Стиль кнопки
    ///   - type: Тип кнопки
    ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
    public init(
      isEnabled: Bool = true,
      text: String?,
      style: CircleButtonView.Style,
      type: CircleButtonView.ButtonType,
      action: @escaping () -> Void
    ) {
      self.isEnabled = isEnabled
      self.text = text
      self.style = style
      self.type = type
      self.action = action
    }
  }
}

// MARK: - ButtonType

extension CircleButtonView {
  public enum ButtonType {
    var size: CGFloat {
      switch self {
      case .large:
        return .s14
      case .small:
        return .s10
      }
    }
    
    /// Большая кнопка
    case large
    /// Маленькая кнопка
    case small
  }
}

// MARK: - Style

extension CircleButtonView {
  public enum Style {
    var imageSystemName: String {
      switch self {
      case .send:
        return "arrow.up"
      case .receive:
        return "arrow.down"
      case .share:
        return "square.and.arrow.up"
      case let .custom(systemNameImage):
        return systemNameImage
      }
    }
    
    /// Отправить
    case send
    /// Получить
    case receive
    /// Поделиться
    case share
    /// Пользовательская картинка
    case custom(systemNameImage: String)
  }
}
