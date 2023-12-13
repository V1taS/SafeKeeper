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
  
  private let model: CircleButtonView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания круглой кнопки
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: CircleButtonView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack {
      createCircleButtonView()
      
      if let text = model.text {
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
        .init(
          content: AnyView(
            ZStack {
              model.style.buttonColor
              
              Image(systemName: model.type.imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.fancy.constant.ghost)
                .frame(height: model.size.buttonSize / 2.6)
                .allowsHitTesting(false)
            }
              .frame(width: model.size.buttonSize, height: model.size.buttonSize)
              .clipShape(Circle())
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
            .init(
              text: "Send",
              type: .custom(systemNameImage: "arrow.up.arrow.down"),
              size: .large,
              action: {}
            )
          )
          
          CircleButtonView(
            .init(
              text: "Receive",
              type: .receive,
              size: .small,
              action: {}
            )
          )
          Spacer()
        }
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}