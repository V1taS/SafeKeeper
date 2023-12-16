//
//  MainButtonView.swift
//
//
//  Created by Vitalii Sosin on 01.12.2023.
//

import SwiftUI
import FancyStyle

public struct MainButtonView: View {
  
  // MARK: - Private properties
  
  @Binding private var text: String
  @Binding private var isEnabled: Bool
  
  private let style: MainButtonView.Style
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - text: Текст, который будет отображаться на кнопке
  ///   - isEnabled: Кнопка включена
  ///   - style: Стиль кнопки
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(text: Binding<String>,
              isEnabled: Binding<Bool> = .constant(true),
              style: MainButtonView.Style = .primary,
              action: @escaping () -> Void) {
    self._text = text
    self.style = style
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    TapGestureView(
      style: .animationZoomOut,
      isSelectable: isEnabled,
      touchesEnded: { action() }
    ) {
      ZStack {
        LinearGradient(
          gradient: Gradient(
            colors: isEnabled ? style.enabledColors : style.disabledColors
          ),
          startPoint: .leading,
          endPoint: .trailing
        )
        
        Text(text)
          .font(.fancy.h3)
          .foregroundColor(.fancy.constant.ghost)
          .padding(.s4)
          .frame(maxWidth: .infinity)
          .lineLimit(Constants.lineLimit)
          .truncationMode(.tail)
          .allowsHitTesting(false)
      }
      .clipShape(RoundedRectangle(cornerRadius: .s4))
      .frame(height: .s13)
    }
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
}

// MARK: - Preview

struct MainButtonView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      VStack {
        MainButtonView(
          text: .constant("Кнопка primary"),
          isEnabled: .constant(true),
          style: .primary,
          action: {}
        )
        
        MainButtonView(
          text: .constant("Кнопка secondary"),
          isEnabled: .constant(true),
          style: .secondary,
          action: {}
        )
      }
      Spacer()
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
