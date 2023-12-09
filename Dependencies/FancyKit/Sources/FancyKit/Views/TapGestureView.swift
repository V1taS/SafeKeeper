//
//  TapGestureView.swift
//
//
//  Created by Vitalii Sosin on 09.12.2023.
//

import SwiftUI
import FancyStyle

public struct TapGestureView<Content: View>: View {
  
  // MARK: - Style
  
  public enum Style {
    /// Кнопка нажата
    var opacityPressedDown: CGFloat {
      switch self {
      case .flash:
        return 0.8
      case .animationZoomOut:
        return 1.0
      case .none:
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
  
  // MARK: - Private properties
  
  private let style: Style
  private let content: Content
  @State private var isPressed = false
  @Binding private var isEnabled: Bool
  private let action: () -> Void
  private let endAction: () -> Void
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - content: Контент
  ///   - style: Стиль вью
  ///   - isEnabled: Вью включена
  ///   - action: Замыкание, которое будет выполняться при нажатии на вью
  ///   - endAction: Замыкание, которое будет выполняться в конце выполнения кнопки
  public init(content: Content,
              style: TapGestureView.Style = .flash,
              isEnabled: Binding<Bool> = .constant(true),
              action: @escaping () -> Void,
              endAction: @escaping () -> Void) {
    self.content = content
    self.style = style
    self._isEnabled = isEnabled
    self.action = action
    self.endAction = endAction
  }
  
  // MARK: - Body
  
  public var body: some View {
    Button(action: {
      if style == .animationZoomOut {
        isPressed = true
      }
      impactFeedback.impactOccurred()
      action()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        isPressed = false
        endAction()
      }
    }) {
      content
    }
    .buttonStyle(TapGestureFlashStyle(style: style))
    .scaleEffect(isPressed ? 0.96 : 1.0)
    .animation(.easeInOut(duration: 0.2), value: isPressed)
    .disabled(!isEnabled)
  }
}

// MARK: - TapGestureFlashStyle

private extension TapGestureView {
  struct TapGestureFlashStyle: ButtonStyle {
    
    // MARK: - Private properties
    
    private let style: Style
    
    // MARK: - Initialization
    
    /// Инициализатор для создания стиля
    /// - Parameters:
    ///   - style: Стиль вью
    public init(style: TapGestureView.Style) {
      self.style = style
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .opacity(configuration.isPressed ? style.opacityPressedDown : style.opacityPressedUp)
    }
  }
}

// MARK: - Preview

struct TapGestureView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      HStack {
        Spacer()
      }
      Spacer()
      TapGestureView(
        content: ZStack {
          Color.fancy.constant.navy
          Text("Кнопка")
        },
        style: .flash,
        isEnabled: .constant(true),
        action: {},
        endAction: {}
      )
      .frame(width: 200, height: 200)
      Spacer()
    }
    .padding(.top, .s26)
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
