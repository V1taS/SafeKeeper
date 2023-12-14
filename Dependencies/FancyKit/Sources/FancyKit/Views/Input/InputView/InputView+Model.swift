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
    @Binding public var text: String
    public var textFont: Font?
    public let placeholder: String
    public let style: Style
    public let keyboardType: UIKeyboardType
    @Binding public var isEnabled: Bool
    public let maxLength: Int
    @Binding public var isError: Bool
    public let isColorFocusBorder: Bool
    public let backgroundColor: Color?
    
    // MARK: - Initialization
    
    /// Инициализатор для создания текстового поля
    /// - Parameters:
    ///   - text: Текст, который будет помещен в текстовое поле
    ///   - textFont: Шрифт для текстового поля
    ///   - placeholder: Подсказка для ввода
    ///   - style: Стиль текстового ввода
    ///   - keyboardType: Стиль клавиатуры
    ///   - isEnabled: Текстовое поле включено
    ///   - maxLength: Максимальная длина символов
    ///   - isError: Ошибка в поле
    ///   - isColorFocusBorder: Подсвечивать границы при фокусировки текстового поля
    ///   - backgroundColor: Цвет фона
    public init(text: Binding<String> = .constant(""),
                textFont: Font? = nil,
                placeholder: String = "",
                style: InputView.Style = .none,
                keyboardType: UIKeyboardType = .default,
                isEnabled: Binding<Bool> = .constant(true),
                maxLength: Int = 100,
                isError: Binding<Bool> = .constant(false),
                isColorFocusBorder: Bool = true,
                backgroundColor: Color? = nil) {
      self._text = text
      self.textFont = textFont
      self.placeholder = placeholder
      self.style = style
      self.keyboardType = keyboardType
      self._isEnabled = isEnabled
      self.maxLength = maxLength
      self._isError = isError
      self.isColorFocusBorder = isColorFocusBorder
      self.backgroundColor = backgroundColor
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
