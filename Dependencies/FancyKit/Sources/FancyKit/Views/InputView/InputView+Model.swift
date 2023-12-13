//
//  InputView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Model

extension InputView {
  public struct Model {
    public let style: Style
    public let placeholder: String
    public let keyboardType: UIKeyboardType
    public let maxLength: Int
    @Binding public var isEnabled: Bool
    @Binding public var text: String
    @Binding public var isError: Bool
    
    // MARK: - Initialization
    
    /// Инициализатор для создания текстового поля
    /// - Parameters:
    ///   - text: Текст, который будет помещен в текстовое поле
    ///   - placeholder: Подсказка для ввода
    ///   - style: Стиль текстового ввода
    ///   - keyboardType: Стиль клавиатуры
    ///   - isEnabled: Текстовое поле включено
    ///   - maxLength: Максимальная длина символов
    ///   - isError: Ошибка в поле
    public init(text: Binding<String> = .constant(""),
                placeholder: String = "",
                style: InputView.Style = .none,
                keyboardType: UIKeyboardType = .default,
                isEnabled: Binding<Bool> = .constant(true),
                maxLength: Int = 100,
                isError: Binding<Bool> = .constant(false)) {
      self._text = text
      self.placeholder = placeholder
      self.style = style
      self.keyboardType = keyboardType
      self._isEnabled = isEnabled
      self.maxLength = maxLength
      self._isError = isError
    }
  }
}

// MARK: - Style

extension InputView {
  public enum Style: Equatable {
    /// Включен хелпер сверху
    var isTopHelper: Bool {
      switch self {
      case .topHelper: return true
      case .leftHelper: return false
      case .none: return false
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
