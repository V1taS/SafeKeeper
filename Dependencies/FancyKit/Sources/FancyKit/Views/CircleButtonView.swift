//
//  CircleButtonView.swift
//
//
//  Created by Vitalii Sosin on 03.12.2023.
//

import SwiftUI
import FancyStyle

public struct CircleButtonView: View {
  
  // MARK: - Style
  
  public enum Style {
    
    var imageSystemName: String {
      switch self {
      case .send:
        return "arrow.up"
      case .receive:
        return "arrow.down"
      case .share:
        return "square.and.arrow.up"
      }
    }
    
    /// Отправить
    case send
    
    /// Получить
    case receive
    
    /// Поделиться
    case share
  }
  
  // MARK: - Private properties
  
  @Binding private var isEnabled: Bool
  private let text: String?
  private let style: Style
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор для создания круглой кнопки
  /// - Parameters:
  ///   - text: Текст, который будет отображаться под кнопкой
  ///   - style: Стиль кнопки
  ///   - isEnabled: Кнопка включена
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(text: String?,
              style: CircleButtonView.Style,
              isEnabled: Binding<Bool> = .constant(true),
              action: @escaping () -> Void) {
    self.text = text
    self.style = style
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack {
      createCircleButtonView()
      
      if let text {
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
        content:  ZStack {
          Color.fancy.constant.navy
          
          Image(systemName: style.imageSystemName)
            .imageScale(.large)
            .font(.fancy.h3)
            .foregroundColor(.fancy.constant.ghost)
            .allowsHitTesting(false)
        }
          .frame(width: .s14, height: .s14)
          .clipShape(Circle())
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
            style: .send,
            isEnabled: .constant(true),
            action: {}
          )
          
          CircleButtonView(
            text: "Send",
            style: .send,
            isEnabled: .constant(false),
            action: {}
          )
          Spacer()
        }
        
        HStack {
          Spacer()
          CircleButtonView(
            text: "Receive",
            style: .receive,
            isEnabled: .constant(true),
            action: {}
          )
          
          CircleButtonView(
            text: "Receive",
            style: .receive,
            isEnabled: .constant(false),
            action: {}
          )
          Spacer()
        }
        .padding(.top)
        
        HStack {
          Spacer()
          CircleButtonView(
            text: nil,
            style: .share,
            isEnabled: .constant(true),
            action: {}
          )
          
          CircleButtonView(
            text: "Share",
            style: .share,
            isEnabled: .constant(false),
            action: {}
          )
          Spacer()
        }
        .padding(.top)
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
