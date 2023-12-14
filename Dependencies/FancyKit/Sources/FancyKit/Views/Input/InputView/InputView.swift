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
  
  private let model: InputView.Model
  @FocusState private var isTextFieldFocused: Bool
  
  // MARK: - Initialization
  
  /// Инициализатор для создания текстового поля
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: InputView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    ZStack {
      VStack {
        Spacer()
        TapGestureView(
          .init(
            content: AnyView(
              model.backgroundColor ?? Color.fancy.constant.navy
            ),
            style: .none,
            isImpactFeedback: false,
            touchesBegan: {},
            touchesEnded: {
              isTextFieldFocused = true
            }
          )
        )
        Spacer()
      }
      
      VStack {
        HStack(spacing: .zero) {
          if case let .leftHelper(text) = model.style {
            Text("\(text)")
              .font(.fancy.h3)
              .foregroundColor(.fancy.constant.slate)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
              .padding(.trailing, .s2)
              .allowsHitTesting(false)
          }
          
          VStack(alignment: .leading, spacing: .zero) {
            if case let .topHelper(text) = model.style {
              Text("\(text)")
                .font(.fancy.b2Medium)
                .foregroundColor(.fancy.constant.slate)
                .lineLimit(Constants.lineLimit)
                .truncationMode(.tail)
                .padding(.top, .s4)
                .allowsHitTesting(false)
            }
            
            TextField("", text: model.$text, axis: .vertical)
              .onChange(of: model.text) { newValue in
                if newValue.count > model.maxLength {
                  model.text = String(newValue.prefix(model.maxLength))
                }
              }
              .autocorrectionDisabled(true)
              .keyboardType(model.keyboardType)
              .disabled(!model.isEnabled)
              .padding(.vertical, .s1)
              .focused($isTextFieldFocused)
              .lineLimit(Constants.lineLimit)
              .font(model.textFont ?? .fancy.b1)
              .foregroundColor(.fancy.constant.ghost)
              .accentColor(model.isError ? .fancy.constant.ruby : .fancy.constant.azure)
              .truncationMode(.tail)
              .padding(.bottom, .s4)
              .padding(.top, model.style.isTopHelper ? .zero : .s4)
              .placeholder(when: model.text.isEmpty) {
                Text(model.placeholder)
                  .padding(.vertical, .s1)
                  .foregroundColor(.fancy.constant.slate).opacity(0.3)
                  .font(model.textFont ?? .fancy.b1)
                  .padding(.bottom, .s4)
                  .padding(.top, model.style.isTopHelper ? .zero : .s4)
              }
              .allowsHitTesting(false)
          }
          
          if (!model.text.isEmpty && isTextFieldFocused) {
            Button(action: {
              model.text = ""
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
    .background(model.backgroundColor ?? Color.fancy.constant.navy)
    .overlay(
      RoundedRectangle(cornerRadius: .s5)
        .stroke(
          getColorFocusBorder(),
          lineWidth: .s1 / 1.5
        )
    )
    .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension InputView {
  func getColorFocusBorder() -> Color {
    guard model.isColorFocusBorder else {
      return .clear
    }
    return model.isError ? .fancy.constant.ruby :
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
        .init(
          text: .constant(""),
          placeholder: "Input view one",
          style: .none,
          keyboardType: .default,
          isEnabled: .constant(true),
          maxLength: 7,
          isError: .constant(false)
        )
      )
      
      InputView(
        .init(
          text: .constant(""),
          placeholder: "Input view two",
          style: .leftHelper(text: "22:"),
          keyboardType: .numberPad,
          isEnabled: .constant(true),
          maxLength: 20,
          isError: .constant(false)
        )
      )
      
      InputView(
        .init(
          text: .constant(""),
          placeholder: "Input view one",
          style: .topHelper(text: "Comments"),
          keyboardType: .default,
          isEnabled: .constant(true),
          maxLength: 7,
          isError: .constant(true)
        )
      )
      Spacer()
    }
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
