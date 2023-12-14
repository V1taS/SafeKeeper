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
  
  private let model: MainButtonView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания основной кнопки
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: MainButtonView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    TapGestureView(
      .init(
        content: AnyView(
          ZStack {
            LinearGradient(
              gradient: Gradient(
                colors: model.isEnabled ? model.style.enabledColors : model.style.disabledColors
              ),
              startPoint: .leading,
              endPoint: .trailing
            )
            
            Text(model.text)
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
        ),
        style: .animationZoomOut,
        isSelectable: model.isEnabled,
        touchesEnded: {
          model.action()
        }
      )
    )
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
          .init(
            text: "Кнопка primary",
            style: .primary,
            isEnabled: .constant(true),
            action: {}
          )
        )
        
        MainButtonView(
          .init(
            text: "Кнопка primary",
            style: .primary,
            isEnabled: .constant(false),
            action: {}
          )
        )
      }
      
      VStack {
        MainButtonView(
          .init(
            text: "Кнопка secondary",
            style: .secondary,
            isEnabled: .constant(true),
            action: {}
          )
        )
        
        MainButtonView(
          .init(
            text: "Кнопка secondary",
            style: .secondary,
            isEnabled: .constant(false),
            action: {}
          )
        )
      }
      .padding(.top)
      Spacer()
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
