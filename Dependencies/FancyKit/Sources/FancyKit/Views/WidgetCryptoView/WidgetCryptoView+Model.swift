//
//  WidgetCryptoView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Model

extension WidgetCryptoView {
  public struct Model: Identifiable {
    /// ID для модельки
    public let id = UUID()
    
    /// Левая сторона виджета
    public let leftSide: WidgetCryptoView.LeftSide
    
    /// Правая сторона виджета
    public let rightSide: WidgetCryptoView.RightSide
    
    /// Дополнительный текст
    public let additionText: String?
    
    /// Дополнительный контент
    public let additionContent: AnyView?
    
    /// Можно ли нажать на ячейку
    public var isSelectable: Bool
    
    /// Замыкание, которое будет выполняться при нажатии на виджет
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки для виджета
    /// - Parameters:
    ///   - leftSide: Левая сторона виджета
    ///   - rightSide: Правая сторона виджета
    ///   - additionText: Дополнительный текст
    ///   - additionContent: Дополнительный контент
    ///   - isSelectable: Можно ли нажать на ячейку
    ///   - action: Замыкание, которое будет выполняться при нажатии на виджет
    public init(_ leftSide: WidgetCryptoView.LeftSide,
                _ rightSide: WidgetCryptoView.RightSide,
                additionText: String?,
                additionContent: AnyView? = nil,
                isSelectable: Bool,
                action: @escaping () -> Void) {
      self.leftSide = leftSide
      self.rightSide = rightSide
      self.additionText = additionText
      self.additionContent = additionContent
      self.isSelectable = isSelectable
      self.action = action
    }
  }
}

// MARK: - TextStyle

extension WidgetCryptoView {
  /// Стиль текста в виджете
  public enum TextStyle {
    /// Цвет из стиля
    var color: Color {
      switch self {
      case .standart:
        return .fancy.constant.ghost
      case .positive:
        return .fancy.constant.lime
      case .negative:
        return .fancy.constant.ruby
      }
    }
    
    /// Стандартный белый цвет
    case standart
    /// Позитивный зеленый цвет
    case positive
    /// Негативный красный цвет
    case negative
  }
}

// MARK: - LeftSide

extension WidgetCryptoView {
  public enum LeftSide {
    case leftSide(
      icon: Data?,
      title: String,
      description: String,
      addition: String?,
      additionStyle: TextStyle
    )
  }
}

// MARK: - RightSide

extension WidgetCryptoView {
  public enum RightSide {
    case rightSide(
      isChevron: Bool,
      title: String,
      titleStyle: TextStyle,
      titleIsSecure: Bool,
      description: String,
      descriptionSecure: Bool
    )
  }
}
