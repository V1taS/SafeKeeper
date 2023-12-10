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
      default:
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
  @Binding private var isEnabled: Bool
  private let touchesBegan: (() -> Void)?
  private let touchesEnded: () -> Void
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - content: Контент
  ///   - style: Стиль вью
  ///   - isEnabled: Вью включена
  ///   - touchesBegan: Замыкание, которое будет выполняться при нажатии на вью
  ///   - touchesEnded: Замыкание, которое будет выполняться в конце выполнения кнопки
  public init(content: Content,
              style: TapGestureView.Style = .flash,
              isEnabled: Binding<Bool> = .constant(true),
              touchesBegan: (() -> Void)? = nil,
              touchesEnded: @escaping () -> Void) {
    self.content = content
    self.style = style
    self._isEnabled = isEnabled
    self.touchesBegan = touchesBegan
    self.touchesEnded = touchesEnded
  }
  
  // MARK: - Body
  
  public var body: some View {
    Button(action: {
      impactFeedback.impactOccurred()
      touchesEnded()
    }) {
      content
    }
    .buttonStyle(TapGestureFlashStyle(
      style: style,
      touchesBegan: {
        touchesBegan?()
      }
    ))
    .disabled(!isEnabled)
  }
}

// MARK: - TapGestureFlashStyle

private extension TapGestureView {
  struct TapGestureFlashStyle: ButtonStyle {
    
    // MARK: - Private properties
    
    private let style: Style
    private let touchesBegan: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания стиля
    /// - Parameters:
    ///   - style: Стиль вью
    ///   - touchesBegan: Замыкание, которое будет выполняться при нажатии на вью
    public init(style: TapGestureView.Style,
                touchesBegan: @escaping () -> Void
    ) {
      self.style = style
      self.touchesBegan = touchesBegan
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
      if configuration.isPressed {
        touchesBegan()
      }
      var scaleEffect: CGFloat = 1.0
      var animation: Bool = false
      
      if style == .animationZoomOut {
        scaleEffect = configuration.isPressed ? 0.96 : 1.0
        animation = configuration.isPressed
      }
      
      return configuration.label
        .scaleEffect(scaleEffect)
        .animation(.easeInOut(duration: 0.2), value: animation)
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
        style: .animationZoomOut,
        isEnabled: .constant(true),
        touchesBegan: {},
        touchesEnded: {}
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
