//
//  CircleButtonView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Model

extension CircleButtonView {
  public struct Model {
    public var isEnabled: Bool
    public let text: String?
    public let type: CircleButtonView.ButtonType
    public let size: CircleButtonView.ButtonSize
    public let style: CircleButtonView.Style
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модели
    /// - Parameters:
    ///   - isEnabled: Кнопка включена
    ///   - text: Текст, который будет отображаться под кнопкой
    ///   - type: Тип кнопки
    ///   - size: Размер кнопки
    ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
    public init(
      isEnabled: Bool = true,
      text: String? = nil,
      type: CircleButtonView.ButtonType,
      size: CircleButtonView.ButtonSize = .large,
      style: CircleButtonView.Style = .standart,
      action: @escaping () -> Void
    ) {
      self.isEnabled = isEnabled
      self.text = text
      self.type = type
      self.size = size
      self.style = style
      self.action = action
    }
  }
}

// MARK: - ButtonSize

extension CircleButtonView {
  public enum ButtonSize {
    var buttonSize: CGFloat {
      switch self {
      case .large:
        return .s14
      case .small:
        return .s11
      }
    }
    
    /// Большая кнопка
    case large
    /// Маленькая кнопка
    case small
  }
}

// MARK: - ButtonType

extension CircleButtonView {
  public enum ButtonType {
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

// MARK: - ButtonType

extension CircleButtonView {
  public enum Style {
    var buttonColor: Color {
      switch self {
      case .standart:
        return Color.fancy.constant.navy
      case let .custom(color):
        return color
      }
    }
    
    /// Стандартный цвет
    case standart
    /// Пользовательский цвет
    case custom(color: Color)
  }
}
