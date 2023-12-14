//
//  TapGestureView+Model.swift
//  
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI
import FancyStyle

// MARK: - Model

extension TapGestureView {
  public struct Model {
    public let style: Style
    public let content: AnyView
    public let isSelectable: Bool
    public let isImpactFeedback: Bool
    public let touchesBegan: (() -> Void)?
    public let touchesEnded: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания основной кнопки
    /// - Parameters:
    ///   - content: Контент
    ///   - style: Стиль вью
    ///   - isEnabled: Можно ли нажать на ячейку
    ///   - isImpactFeedback: Тактильная обратная связь
    ///   - touchesBegan: Замыкание, которое будет выполняться при нажатии на вью
    ///   - touchesEnded: Замыкание, которое будет выполняться в конце выполнения кнопки
    public init(content: AnyView,
                style: TapGestureView.Style = .flash,
                isSelectable: Bool = true,
                isImpactFeedback: Bool = true,
                touchesBegan: (() -> Void)? = nil,
                touchesEnded: @escaping () -> Void) {
      self.content = content
      self.style = style
      self.isSelectable = isSelectable
      self.touchesBegan = touchesBegan
      self.isImpactFeedback = isImpactFeedback
      self.touchesEnded = touchesEnded
    }
  }
}

// MARK: - Style

extension TapGestureView {
  public enum Style {
    /// Кнопка нажата
    var opacityPressedDown: CGFloat {
      switch self {
      case .flash:
        return 0.8
      default:
        return 1.0
      }
    }
    
    /// Кнопка отжата
    var opacityPressedUp: CGFloat {
      return 1
    }
    
    /// Вспышка
    case flash
    
    /// Анимация уменьшения кнопки
    case animationZoomOut
    
    /// Статичная
    case none
  }
}
