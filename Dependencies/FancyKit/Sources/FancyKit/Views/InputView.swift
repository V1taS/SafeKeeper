//
//  InputView.swift
//
//
//  Created by Vitalii Sosin on 04.12.2023.
//

import SwiftUI
import FancyStyle

// TODO: - Добавить в правом нижнем углу счетчик символов
public struct InputView: View {
  
  // MARK: - Style
  
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
  
  // MARK: - Private properties
  
  private let style: Style
  private let placeholder: String
  private let keyboardType: UIKeyboardType
  private let maxLength: Int
  @Binding private var isEnabled: Bool
  @Binding private var text: String
  @Binding private var isError: Bool
  @FocusState private var isTextFieldFocused: Bool
  
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
              style: InputView.Style,
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
  
  // MARK: - Body
  
  public var body: some View {
    VStack {
      HStack(spacing: .zero) {
        if case let .leftHelper(text) = style {
          Text("\(text)")
            .font(.fancy.h3)
            .foregroundColor(.fancy.constant.slate)
            .lineLimit(Constants.lineLimit)
            .truncationMode(.tail)
            .padding(.trailing, .s2)
            .allowsHitTesting(false)
        }
        
        VStack(alignment: .leading, spacing: .zero) {
          if case let .topHelper(text) = style {
            Text("\(text)")
              .font(.fancy.b2Medium)
              .foregroundColor(.fancy.constant.slate)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
              .padding(.top, .s4)
              .allowsHitTesting(false)
          }
          
          TextField("", text: $text,  axis: .vertical)
            .onChange(of: text) { newValue in
              if newValue.count > maxLength {
                text = String(newValue.prefix(maxLength))
              }
            }
            .focused($isTextFieldFocused)
            .autocorrectionDisabled(true)
            .keyboardType(keyboardType)
            .disabled(!isEnabled)
            .padding(.vertical, .s1)
            .lineLimit(Constants.lineLimit)
            .font(.fancy.b1)
            .foregroundColor(.fancy.constant.ghost)
            .accentColor(isError ? .fancy.constant.ruby : .fancy.constant.azure)
            .truncationMode(.tail)
            .padding(.bottom, .s4)
            .padding(.top, style.isTopHelper ? .zero : .s4)
            .placeholder(when: text.isEmpty) {
              Text(placeholder)
                .padding(.vertical, .s1)
                .foregroundColor(.fancy.constant.slate).opacity(0.3)
                .font(.fancy.b1)
                .padding(.bottom, .s4)
                .padding(.top, style.isTopHelper ? .zero : .s4)
            }
        }
        
        if !text.isEmpty && isTextFieldFocused {
          Button(action: {
            text = ""
          }) {
            Image(systemName: "xmark.circle.fill")
              .font(.fancy.h3)
              .foregroundColor(.fancy.constant.slate)
              .padding(.leading, .s3)
          }
        }
      }
    }
    .frame(width: .infinity)
    .padding(.horizontal, .s4)
    .background(Color.fancy.constant.navy)
    .overlay(
      RoundedRectangle(cornerRadius: .s5)
        .stroke(
          isError ? .fancy.constant.ruby :
            isTextFieldFocused ? Color.fancy.constant.azure : Color.clear,
          lineWidth: .s1 / 1.5
        )
    )
    .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension InputView {}

// MARK: - Constants

private enum Constants {
  static let lineLimit = ...100
}

// MARK: - Extension placeholder

private extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
}

// MARK: - Preview

struct InputView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: .s4) {
      Spacer()
      InputView(
        text: .constant(""),
        placeholder: "Input view one",
        style: .none,
        keyboardType: .default,
        isEnabled: .constant(true),
        maxLength: 7,
        isError: .constant(false)
      )
      
      InputView(
        text: .constant(""),
        placeholder: "Input view two",
        style: .leftHelper(text: "22:"),
        keyboardType: .numberPad,
        isEnabled: .constant(true),
        maxLength: 20,
        isError: .constant(false)
      )
      
      InputView(
        text: .constant(""),
        placeholder: "Input view one",
        style: .topHelper(text: "Comments"),
        keyboardType: .default,
        isEnabled: .constant(true),
        maxLength: 7,
        isError: .constant(true)
      )
      Spacer()
    }
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
