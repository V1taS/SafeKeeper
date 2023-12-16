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
  
  @Binding private var isEnabled: Bool
  
  private let style: RoundButtonView.Style
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - isEnabled: Кнопка включена
  ///   - style: Стиль кнопки
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(isEnabled: Binding<Bool> = .constant(true),
              style: RoundButtonView.Style,
              action: @escaping () -> Void) {
    self.style = style
    self._isEnabled = isEnabled
    self.action = action
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
        style: .animationZoomOut,
        isSelectable: isEnabled,
        touchesEnded: { action() }
      ) {
        HStack(alignment: .center, spacing: .s2) {
          if let image = style.image {
            Image(uiImage: image)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: .s4, height: .s4)
              .allowsHitTesting(false)
          }
          
          Text(style.text)
            .font(.fancy.b1Medium)
            .foregroundColor(.fancy.constant.ghost)
            .lineLimit(1)
            .truncationMode(.tail)
            .allowsHitTesting(false)
            .multilineTextAlignment(.center)
        }
        .roundedEdge(backgroundColor: .fancy.constant.navy)
      }
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
          style: .copy(text: "Copy"),
          action: {}
        )
        RoundButtonView(
          style: .custom(imageData: nil, text: "Max"),
          action: {}
        )
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
