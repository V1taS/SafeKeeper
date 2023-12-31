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
  @Binding private var isSecureField: Bool
  @Binding private var bottomHelper: String?
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
  private let bottomHelperFont: Font?
  private let backgroundColor: Color?
  private let rightContentView: AnyView?
  
  
  // MARK: - Initialization
  
  /// Инициализатор для создания текстового поля
  /// - Parameters:
  ///   - text: Текст, который будет помещен в текстовое поле
  ///   - isSecureField: Защищенный режим включен
  ///   - bottomHelper: Текст подсказка снизу
  ///   - isError: Ошибка в поле
  ///   - isEnabled: Текстовое поле включено
  ///   - isTextFieldFocused: Фокус на текстовое поле
  ///   - isColorFocusBorder: Подсвечивать границы при фокусировки текстового поля
  ///   - placeholder: Подсказка для ввода
  ///   - style: Стиль текстового ввода
  ///   - keyboardType: Стиль клавиатуры
  ///   - maxLength: Максимальная длина символов
  ///   - textFont: Шрифт для текстового поля
  ///   - bottomHelperFont: Шрифт для нижнего хелпера
  ///   - backgroundColor: Цвет фона
  public init(text: Binding<String>,
              isSecureField: Binding<Bool> = .constant(false),
              bottomHelper: Binding<String?>,
              isError: Binding<Bool> = .constant(false),
              isEnabled: Binding<Bool> = .constant(true),
              isTextFieldFocused: Binding<Bool?> = .constant(nil),
              isColorFocusBorder: Binding<Bool> = .constant(true),
              placeholder: String,
              style: InputView.Style = .none,
              keyboardType: UIKeyboardType = .default,
              maxLength: Int = 100,
              textFont: Font? = nil,
              bottomHelperFont: Font? = nil,
              backgroundColor: Color? = nil,
              rightContentView: AnyView? = nil) {
    self._text = text
    self._isSecureField = isSecureField
    self._bottomHelper = bottomHelper
    self._isError = isError
    self._isEnabled = isEnabled
    self._isTextFieldFocusedBinding = isTextFieldFocused
    self._isColorFocusBorder = isColorFocusBorder
    self.placeholder = placeholder
    self.style = style
    self.keyboardType = keyboardType
    self.maxLength = maxLength
    self.textFont = textFont
    self.bottomHelperFont = bottomHelperFont
    self.backgroundColor = backgroundColor
    self.rightContentView = rightContentView
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(spacing: .zero) {
      createInputView()
      createBottomHelperView()
    }
  }
}

// MARK: - Private

private extension InputView {
  func createInputView() -> AnyView {
    AnyView(
      ZStack {
        VStack {
          Spacer()
          TapGestureView(
            style: .none,
            isImpactFeedback: false,
            touchesEnded: { isTextFieldFocused = true }
          ) {
            backgroundColor ?? Color.fancy.constant.navy
          }
          Spacer()
        }
        
        VStack {
          HStack(spacing: .zero) {
            // MARK: - leftHelper
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
              // MARK: - topHelper
              if case let .topHelper(text) = style {
                Text("\(text)")
                  .font(.fancy.b2Medium)
                  .foregroundColor(.fancy.constant.slate)
                  .lineLimit(Constants.lineLimit)
                  .truncationMode(.tail)
                  .padding(.top, .s4)
                  .allowsHitTesting(false)
              }
              
              createTextField()
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
            
            if let rightContentView {
              rightContentView
                .frame(height: .s5)
                .padding(.leading, .s3)
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
    )
  }
  
  func createTextField() -> AnyView {
    AnyView(
      getTextField()
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
    )
  }
  
  func getTextField() -> AnyView {
    if isSecureField {
      return AnyView(
        SecureField("", text: $text)
      )
    } else {
      return AnyView(
        TextField("", text: $text, axis: .vertical)
      )
    }
  }
  
  func createBottomHelperView() -> AnyView {
    guard let bottomHelper else {
      return AnyView(EmptyView())
    }
    
    return AnyView(
      HStack {
        Text("\(bottomHelper)")
          .font(bottomHelperFont ?? .fancy.b3)
          .foregroundColor(
            isError ? .fancy.constant.ruby : .fancy.constant.slate
          )
          .lineLimit(Constants.lineLimit)
          .truncationMode(.tail)
          .padding(.trailing, .s2)
          .allowsHitTesting(false)
        Spacer()
      }
        .padding(.top, .s1)
        .padding(.horizontal, .s4)
    )
  }
  
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
        bottomHelper: .constant("Helper text"),
        isError: .constant(false),
        isEnabled: .constant(true),
        isTextFieldFocused: .constant(nil),
        isColorFocusBorder: .constant(true),
        placeholder: "Placeholder",
        style: .none,
        keyboardType: .default,
        maxLength: 10,
        backgroundColor: nil
      )
      Spacer()
    }
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
