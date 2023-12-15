//
//  TapGestureView.swift
//
//
//  Created by Vitalii Sosin on 09.12.2023.
//

import SwiftUI
import FancyStyle

public struct TapGestureView: View {
  
  // MARK: - Private properties
  
  private let content: AnyView
  private let style: Style
  private let isSelectable: Bool
  private let isImpactFeedback: Bool
  private let touchesBegan: (() -> Void)?
  private let touchesEnded: () -> Void
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - content: Контент
  ///   - style: Стиль вью
  ///   - isEnabled: Можно ли нажать на ячейку
  ///   - isImpactFeedback: Тактильная обратная связь
  ///   - touchesBegan: Замыкание, которое будет выполняться при нажатии на вью
  ///   - touchesEnded: Замыкание, которое будет выполняться в конце выполнения кнопки
  public init(content: AnyView,
              style: TapGestureView.Style = .flash,
              isSelectable: Bool = true,
              isImpactFeedback: Bool = true,
              touchesBegan: (() -> Void)? = nil,
              touchesEnded: @escaping () -> Void) {
    self.content = content
    self.style = style
    self.isSelectable = isSelectable
    self.touchesBegan = touchesBegan
    self.isImpactFeedback = isImpactFeedback
    self.touchesEnded = touchesEnded
  }
  
  // MARK: - Body
  
  public var body: some View {
    Button(action: {
      if isImpactFeedback {
        impactFeedback.impactOccurred()
      }
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
    .disabled(!isSelectable)
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
        content: AnyView(ZStack {
          Color.fancy.constant.navy
          Text("Кнопка")
        }),
        style: .animationZoomOut,
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
