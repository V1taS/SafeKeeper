//
//  RoundButtonView.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle

public struct RoundButtonView: View {
  
  // MARK: - Style
  
  public enum Style {
    var text: String {
      switch self {
      case let .custom(_, text):
        return text
      case let .copy(text):
        return text
      }
    }
    
    var image: UIImage? {
      switch self {
      case let .custom(image, _):
        guard let image else {
          return nil
        }
        return UIImage(data: image)?.recolorImage(with: .fancy.constant.ghost)
      case .copy:
        return UIImage(systemName: "rectangle.on.rectangle")?.recolorImage(with: .fancy.constant.ghost)
      }
    }
    
    /// Пользовательские настройки
    case custom(image: Data?, text: String)
    
    /// Копировать
    case copy(text: String)
  }
  
  // MARK: - Private properties
  
  @Binding private var isEnabled: Bool
  private let style: Style
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор для создания овальной кнопки
  /// - Parameters:
  ///   - style: Стиль кнопки
  ///   - isEnabled: Кнопка включена
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(style: RoundButtonView.Style,
              isEnabled: Binding<Bool> = .constant(true),
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
        content:
          HStack(alignment: .center, spacing: .s2) {
            if let image = style.image {
              Image(uiImage: image)
                .resizable()
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
        ,
        style: .animationZoomOut,
        isEnabled: .constant(isEnabled),
        touchesBegan: {},
        touchesEnded: {
          action()
        }
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
          style: .copy(text: "Copy"),
          isEnabled: .constant(true),
          action: {}
        )
        
        RoundButtonView(
          style: .custom(image: nil, text: "Max"),
          isEnabled: .constant(true),
          action: {}
        )
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
