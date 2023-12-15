//
//  InputView.swift
//
//
//  Created by Vitalii Sosin on 04.12.2023.
//

import SwiftUI
import FancyStyle

public struct InputView: View {
  
  // MARK: - Private properties
  
  @Binding private var text: String
  @Binding private var isError: Bool
  @Binding private var isEnabled: Bool
  @FocusState private var isTextFieldFocused: Bool
  @Binding private var isTextFieldFocusedBinding: Bool?
  @Binding private var isColorFocusBorder: Bool
  
  private let placeholder: String
  private let style: InputView.Style
  private let keyboardType: UIKeyboardType
  private let maxLength: Int
  private let textFont: Font?
  private let backgroundColor: Color?
  
  // MARK: - Initialization
  
  /// Инициализатор для создания текстового поля
  /// - Parameters:
  ///   - text: Текст, который будет помещен в текстовое поле
  ///   - isError: Ошибка в поле
  ///   - isEnabled: Текстовое поле включено
  ///   - isTextFieldFocused: Фокус на текстовое поле
  ///   - isColorFocusBorder: Подсвечивать границы при фокусировки текстового поля
  ///   - placeholder: Подсказка для ввода
  ///   - style: Стиль текстового ввода
  ///   - keyboardType: Стиль клавиатуры
  ///   - maxLength: Максимальная длина символов
  ///   - textFont: Шрифт для текстового поля
  ///   - backgroundColor: Цвет фона
  public init(text: Binding<String>,
              isError: Binding<Bool> = .constant(false),
              isEnabled: Binding<Bool> = .constant(true),
              isTextFieldFocused: Binding<Bool?> = .constant(nil),
              isColorFocusBorder: Binding<Bool> = .constant(true),
              placeholder: String,
              style: InputView.Style = .none,
              keyboardType: UIKeyboardType = .default,
              maxLength: Int = 100,
              textFont: Font? = nil,
              backgroundColor: Color? = nil) {
    self._text = text
    self._isError = isError
    self._isEnabled = isEnabled
    self._isTextFieldFocusedBinding = isTextFieldFocused
    self._isColorFocusBorder = isColorFocusBorder
    self.placeholder = placeholder
    self.style = style
    self.keyboardType = keyboardType
    self.maxLength = maxLength
    self.textFont = textFont
    self.backgroundColor = backgroundColor
  }
  
  // MARK: - Body
  
  public var body: some View {
    ZStack {
      VStack {
        Spacer()
        TapGestureView(
          content: AnyView(
            backgroundColor ?? Color.fancy.constant.navy
          ),
          style: .none,
          isImpactFeedback: false,
          touchesBegan: {},
          touchesEnded: {
            isTextFieldFocused = true
          }
        )
        Spacer()
      }
      
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
            
            TextField("", text: $text, axis: .vertical)
              .onChange(of: text) { newValue in
                if newValue.count > maxLength {
                  text = String(newValue.prefix(maxLength))
                }
              }
              .autocorrectionDisabled(true)
              .keyboardType(keyboardType)
              .disabled(!isEnabled)
              .padding(.vertical, .s1)
              .focused($isTextFieldFocused)
              .lineLimit(Constants.lineLimit)
              .font(textFont ?? .fancy.b1)
              .foregroundColor(.fancy.constant.ghost)
              .accentColor(isError ? .fancy.constant.ruby : .fancy.constant.azure)
              .truncationMode(.tail)
              .padding(.bottom, .s4)
              .padding(.top, style.isTopHelper ? .zero : .s4)
              .placeholder(when: text.isEmpty) {
                Text(placeholder)
                  .padding(.vertical, .s1)
                  .foregroundColor(.fancy.constant.slate).opacity(0.3)
                  .font(textFont ?? .fancy.b1)
                  .padding(.bottom, .s4)
                  .padding(.top, style.isTopHelper ? .zero : .s4)
              }
              .allowsHitTesting(false)
          }
          
          if (!text.isEmpty && isTextFieldFocused) {
            Button(action: {
              text = ""
            }) {
              Image(systemName: "xmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: .s5)
                .foregroundColor(.fancy.constant.slate)
                .padding(.leading, .s3)
            }
          }
        }
      }
    }
    .frame(width: .infinity)
    .padding(.horizontal, .s4)
    .background(backgroundColor ?? Color.fancy.constant.navy)
    .overlay(
      RoundedRectangle(cornerRadius: .s5)
        .stroke(
          getColorFocusBorder(),
          lineWidth: .s1 / 1.5
        )
    )
    .clipShape(RoundedRectangle(cornerRadius: .s5))
    .onChange(of: isTextFieldFocusedBinding) { newValue in
      if let newValue {
        isTextFieldFocused = newValue
      }
    }
  }
}

// MARK: - Private

private extension InputView {
  func getColorFocusBorder() -> Color {
    guard isColorFocusBorder else {
      return .clear
    }
    return isError ? .fancy.constant.ruby :
    isTextFieldFocused ? Color.fancy.constant.azure : Color.clear
  }
}

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
        text: .constant("Hello world"),
        isError: .constant(false),
        isEnabled: .constant(true),
        isTextFieldFocused: .constant(nil),
        isColorFocusBorder: .constant(true),
        placeholder: "Placeholder",
        style: .none,
        keyboardType: .default,
        maxLength: 10,
        textFont: nil,
        backgroundColor: nil
      )
      Spacer()
    }
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
