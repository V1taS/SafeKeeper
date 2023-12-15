//
//  InputContentSizeView.swift
//
//
//  Created by Vitalii Sosin on 14.12.2023.
//

import SwiftUI

// Добавить плейсхолдер
public struct InputContentSizeView: View {
  
  // MARK: - Private properties
  
  @FocusState private var isTextFieldFocused: Bool
  @Binding private var text: String
  private let keyboardType: UIKeyboardType
  private let maxLength: Int
  
  // MARK: - Initialization
  
  /// Инициализатор для создания текстового поля
  /// - Parameters:
  ///   - text: Текст, который будет помещен в текстовое поле
  ///   - keyboardType: Стиль клавиатуры
  ///   - maxLength: Максимальная длина символов
  public init(text: Binding<String>,
              keyboardType: UIKeyboardType = .numberPad,
              maxLength: Int = 20) {
    self._text = text
    self.keyboardType = keyboardType
    self.maxLength = maxLength
  }
  
  // MARK: - Body
  
  public var body: some View {
    TextField("", text: $text)
      .frame(maxWidth: Constants.maxWidth)
      .font(Font.fancy.largeTitle)
      .fontWeight(.bold)
      .fixedSize()
      .onChange(of: text) { newValue in
        if newValue.count > maxLength {
          text = String(newValue.prefix(maxLength))
        }
      }
      .autocorrectionDisabled(true)
      .keyboardType(keyboardType)
      .focused($isTextFieldFocused)
      .lineLimit(Constants.lineLimit)
      .foregroundColor(.fancy.constant.ghost)
      .accentColor(.fancy.constant.azure)
      .truncationMode(.tail)
      .onAppear {
        isTextFieldFocused = true
      }
  }
}

// MARK: - Private

private extension InputContentSizeView {}

// MARK: - Constants

private enum Constants {
  static let maxWidth: CGFloat = UIScreen.main.bounds.width / 1.7
  static let lineLimit = ...100
}

// MARK: - Preview

struct InputContentSizeView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: .s4) {
      Spacer()
      HStack {
        InputContentSizeView(
          text: .constant("123")
        )
        Circle()
      }
      Spacer()
    }
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
