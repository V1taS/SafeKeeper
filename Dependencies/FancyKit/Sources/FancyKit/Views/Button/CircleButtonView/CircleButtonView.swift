//
//  CircleButtonView.swift
//
//
//  Created by Vitalii Sosin on 03.12.2023.
//

import SwiftUI
import FancyStyle

public struct CircleButtonView: View {
  
  // MARK: - Private properties
  
  @Binding private var isEnabled: Bool
  
  private let text: String?
  private let type: CircleButtonView.ButtonType
  private let size: CircleButtonView.ButtonSize
  private let style: CircleButtonView.Style
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - isEnabled: Кнопка включена
  ///   - text: Текст, который будет отображаться под кнопкой
  ///   - type: Тип кнопки
  ///   - size: Размер кнопки
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(
    isEnabled: Binding<Bool> = .constant(true),
    text: String? = nil,
    type: CircleButtonView.ButtonType,
    size: CircleButtonView.ButtonSize = .large,
    style: CircleButtonView.Style = .standart,
    action: @escaping () -> Void
  ) {
    self._isEnabled = isEnabled
    self.text = text
    self.type = type
    self.size = size
    self.style = style
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack {
      createCircleButtonView()
      
      if let text = text {
        Text(text)
          .font(.fancy.b1)
          .foregroundColor(.fancy.constant.slate)
          .frame(maxWidth: .s17)
          .lineLimit(Constants.lineLimit)
          .truncationMode(.tail)
          .padding(.top, .s1)
          .allowsHitTesting(false)
      }
    }
  }
}

// MARK: - Private

private extension CircleButtonView {
  func createCircleButtonView() -> AnyView {
    AnyView(
      TapGestureView(
        content: AnyView(
          ZStack {
            style.buttonColor
            
            Image(systemName: type.imageSystemName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundColor(.fancy.constant.ghost)
              .frame(height: size.buttonSize / 2.6)
              .allowsHitTesting(false)
          }
            .frame(width: size.buttonSize, height: size.buttonSize)
            .clipShape(Circle())
        ),
        style: .animationZoomOut,
        isSelectable: isEnabled,
        touchesEnded: {
          action()
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

struct CircleButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      HStack {
        Color.fancy.constant.onyx
      }
      
      VStack {
        HStack {
          Spacer()
          CircleButtonView(
            text: "Send",
            type: .custom(systemNameImage: "arrow.up.arrow.down"),
            size: .large,
            action: {}
          )
          CircleButtonView(
            text: "Receive",
            type: .receive,
            size: .small,
            action: {}
          )
          Spacer()
        }
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
