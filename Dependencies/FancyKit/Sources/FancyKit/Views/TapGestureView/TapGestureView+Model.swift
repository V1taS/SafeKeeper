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
    @Binding public var isEnabled: Bool
    public let touchesBegan: (() -> Void)?
    public let touchesEnded: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания основной кнопки
    /// - Parameters:
    ///   - content: Контент
    ///   - style: Стиль вью
    ///   - isEnabled: Вью включена
    ///   - touchesBegan: Замыкание, которое будет выполняться при нажатии на вью
    ///   - touchesEnded: Замыкание, которое будет выполняться в конце выполнения кнопки
    public init(content: AnyView,
                style: TapGestureView.Style = .flash,
                isEnabled: Binding<Bool> = .constant(true),
                touchesBegan: (() -> Void)? = nil,
                touchesEnded: @escaping () -> Void) {
      self.content = content
      self.style = style
      self._isEnabled = isEnabled
      self.touchesBegan = touchesBegan
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
