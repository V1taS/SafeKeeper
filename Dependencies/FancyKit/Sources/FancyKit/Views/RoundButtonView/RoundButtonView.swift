//
//  RoundButtonView.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle

public struct RoundButtonView: View {
  
  // MARK: - Private properties
  
  private let model: RoundButtonView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания овальной кнопки
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: RoundButtonView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    createRoundButtonView()
  }
}

// MARK: - Private

private extension RoundButtonView {
  func createRoundButtonView() -> AnyView {
    AnyView(
      TapGestureView(
        .init(
          content: AnyView(
            HStack(alignment: .center, spacing: .s2) {
              if let image = model.style.image {
                Image(uiImage: image)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: .s4, height: .s4)
                  .allowsHitTesting(false)
              }
              
              Text(model.style.text)
                .font(.fancy.b1Medium)
                .foregroundColor(.fancy.constant.ghost)
                .lineLimit(1)
                .truncationMode(.tail)
                .allowsHitTesting(false)
                .multilineTextAlignment(.center)
            }
              .roundedEdge(backgroundColor: .fancy.constant.navy)
          ),
          style: .animationZoomOut,
          isEnabled: .constant(model.isEnabled),
          touchesEnded: {
            model.action()
          }
        )
      )
    )
  }
}

// MARK: - Preview

struct RoundButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      HStack {
        Color.fancy.constant.onyx
      }
      
      HStack {
        RoundButtonView(
          .init(
            style: .copy(text: "Copy"),
            action: {}
          )
        )
        
        RoundButtonView(
          .init(
            style: .custom(image: nil, text: "Max"),
            action: {}
          )
        )
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
