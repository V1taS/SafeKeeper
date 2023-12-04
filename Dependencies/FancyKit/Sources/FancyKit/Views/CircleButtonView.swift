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
      }
    }
    
    /// Отправить
    case send
    
    /// Получить
    case receive
  }
  
  // MARK: - Public properties
  
  @Binding public var isEnabled: Bool
  
  // MARK: - Private properties
  
  @State private var isPressed = false
  private let text: String
  private let style: Style
  private let action: () -> Void
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания круглой кнопки
  /// - Parameters:
  ///   - text: Текст, который будет отображаться под кнопкой
  ///   - style: Стиль кнопки
  ///   - isEnabled: Кнопка включена
  ///   - action: Замыкание, которое будет выполняться при нажатии на кнопку
  public init(text: String,
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
      
      Text(text)
        .font(.fancy.b1)
        .fontWeight(.semibold)
        .foregroundColor(.fancy.constant.ghost)
        .frame(maxWidth: .s17)
        .lineLimit(Constants.lineLimit)
        .truncationMode(.tail)
        .padding(.top, .s1)
    }
  }
}

// MARK: - Private

private extension CircleButtonView {
  func createCircleButtonView() -> AnyView {
    AnyView(
      ZStack {
        Color.fancy.constant.navy
          .frame(width: .s14, height: .s14)
          .clipShape(Circle())
          .disabled(!isEnabled)
          .opacity(isEnabled ? 1 : 0.3)
          .onLongPressGesture(
            minimumDuration: .infinity,
            maximumDistance: .infinity,
            pressing: { isPressing in
              if isEnabled {
                withAnimation(.easeInOut(duration: 0.2)) {
                  isPressed = isPressing
                }
              }
            },
            perform: {
              action()
              impactFeedback.impactOccurred()
            }
          )
        
        Image(systemName: style.imageSystemName)
          .imageScale(.large)
          .font(.fancy.h3)
          .foregroundColor(.fancy.constant.ghost)
      }
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
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
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
