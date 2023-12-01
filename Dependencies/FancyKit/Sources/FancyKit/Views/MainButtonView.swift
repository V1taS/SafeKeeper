//
//  MainButtonView.swift
//
//
//  Created by Vitalii Sosin on 01.12.2023.
//

import SwiftUI
import FancyStyle

public struct MainButtonView: View {
  
  // MARK: - Style
  
  public enum Style {
    
    /// Стиль активной кнопки
    var enabledColors: [Color] {
      switch self {
      case .primary:
        return Constants.primaryEnabledColors
      case .secondary:
        return Constants.secondaryEnabledColors
      }
    }
    
    /// Стиль не активной кнопки
    var disabledColors: [Color] {
      switch self {
      case .primary:
        return Constants.primaryDisabledColors
      case .secondary:
        return Constants.secondaryDisabledColors
      }
    }
    
    /// Основной стиль
    case primary
    
    /// Вторичный стиль
    case secondary
  }
  
  // MARK: - Public properties
  
  @Binding public var isEnabled: Bool
  
  // MARK: - Private properties
  
  private let text: String
  private let style: Style
  @State private var isPressed = false
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - text: Текст, который будет отображаться на кнопке
  ///   - state: Состояние кнопки, которое может быть `.enabled` (включено) или `.disabled` (выключено). По умолчанию состояние `.enabled`
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  init(text: String,
       style: MainButtonView.Style = .primary,
       isEnabled: Binding<Bool> = .constant(true),
       action: @escaping () -> Void) {
    self.text = text
    self.style = style
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    Button(action: action) {
      Text(text)
        .font(.fancy.h3)
        .fontWeight(.semibold)
        .foregroundColor(.fancy.constant.ghost)
        .padding(.s4)
        .frame(maxWidth: .infinity)
        .lineLimit(Constants.lineLimit)
        .truncationMode(.tail)
    }
    .background(
      LinearGradient(
        gradient: Gradient(
          colors: isEnabled ? style.enabledColors : style.disabledColors
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
    )
    .cornerRadius(.s4)
    .disabled(!isEnabled)
    .scaleEffect(isPressed ? 0.96 : 1.0)
    .animation(.easeInOut(duration: 0.2), value: isPressed)
    .onLongPressGesture(
      minimumDuration: .infinity,
      maximumDistance: .infinity,
      pressing: { isPressing in
        if isEnabled {
          withAnimation(.easeInOut(duration: 0.2)) {
            isPressed = isPressing
          }
        }
      },
      perform: {}
    )
  }
}

private enum Constants {
  static let primaryEnabledColors: [Color] = [
    Color.fancy.constant.azure,
    Color.fancy.constant.azure.opacity(0.8)
  ]
  static let primaryDisabledColors: [Color] = [
    Color.fancy.constant.azure.opacity(0.3),
    Color.fancy.constant.azure.opacity(0.2)
  ]
  
  static let secondaryEnabledColors: [Color] = [
    Color.fancy.constant.navy,
    Color.fancy.constant.navy.opacity(0.8)
  ]
  static let secondaryDisabledColors: [Color] = [
    Color.fancy.constant.navy.opacity(0.3),
    Color.fancy.constant.navy.opacity(0.2)
  ]
  static let lineLimit = 1
}

// MARK: - Preview

@available(iOS 14.0, *)
struct MainButtonView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      VStack {
        MainButtonView(
          text: "Кнопка primary",
          style: .primary,
          isEnabled: .constant(true),
          action: {}
        )
        
        MainButtonView(
          text: "Кнопка primary",
          style: .primary,
          isEnabled: .constant(false),
          action: {}
        )
      }
      
      VStack {
        MainButtonView(
          text: "Кнопка secondary",
          style: .secondary,
          isEnabled: .constant(true),
          action: {}
        )
        MainButtonView(
          text: "Кнопка secondary",
          style: .secondary,
          isEnabled: .constant(false),
          action: {}
        )
      }
      .padding(.top)
      Spacer()
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
