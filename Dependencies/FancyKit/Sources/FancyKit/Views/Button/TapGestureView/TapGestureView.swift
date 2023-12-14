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
  
  private let model: TapGestureView.Model
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: TapGestureView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    Button(action: {
      if model.isImpactFeedback {
        impactFeedback.impactOccurred()
      }
      model.touchesEnded()
    }) {
      model.content
    }
    .buttonStyle(TapGestureFlashStyle(
      style: model.style,
      touchesBegan: {
        model.touchesBegan?()
      }
    ))
    .disabled(!model.isSelectable)
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
        .init(
          content: AnyView(ZStack {
            Color.fancy.constant.navy
            Text("Кнопка")
          }),
          style: .animationZoomOut,
          touchesBegan: {},
          touchesEnded: {}
        )
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
