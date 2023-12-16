//
//  PasscodeFieldView.swift
//
//
//  Created by Vitalii Sosin on 15.12.2023.
//

import SwiftUI
import FancyStyle

/// Обработчик от Passcode
/// - Parameters:
///   - pin: пин код который ввел пользователь с клавиатуры
///   - isSuccess: Присваиваем нашей вью Успех или Ошибка, когда успех или ошибка появляются подсказки снизу
///   - helperText: Подсказка снизу, если nil то не будет подсказки
///   - completion: Замыкание которое выполняется когда пользователь ввел все символы
public typealias PasscodeHandler = (
  _ pin: String,
  _ closure: (
    _ isSuccess: Bool,
    _ helperText: String?,
    _ completion: (() -> Void)?
  ) -> Void
) -> Void

// TODO: - Проверить на реальном устройстве появление клавиатуры сразу
public struct PasscodeFieldView: View {
  
  // MARK: - Private properties
  
  @Binding private var title: String
  @Binding private var pin: String
  @State private var helperText: String?
  @State private var isDisabled = false
  @State private var passcodeState: PasscodeFieldView.PasscodeState = .standart
  
  private let maxDigits: Int
  private let handler: PasscodeHandler
  private var indices: [Int] { Array(.zero..<maxDigits) }
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - title: Заголовок
  ///   - pin: Пин код
  ///   - maxDigits: Максимальное количество символов
  ///   - handler: Обработчик
  public init(
    title: Binding<String>,
    pin: Binding<String>,
    maxDigits: Int = 4,
    handler: @escaping PasscodeHandler
  ) {
    self._title = title
    self._pin = pin
    self.maxDigits = maxDigits
    self.handler = handler
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(spacing: .s5) {
      Text(title)
        .font(.fancy.h1)
        .lineLimit(Constants.lineLimit)
        .foregroundColor(.fancy.constant.ghost)
        .allowsHitTesting(false)
      
      ZStack {
        createPinDots()
      }
      
      if let helperText {
        Text(helperText)
          .font(.fancy.b1Medium)
          .lineLimit(Constants.lineLimit)
          .foregroundColor(passcodeState.color)
          .allowsHitTesting(false)
      }
    }
    .onChange(of: pin) { _ in
      submitPin()
    }
  }
}

// MARK: - Private

private extension PasscodeFieldView {
  func triggerHapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
  
  func createPinDots() -> AnyView {
    AnyView(
      HStack(spacing: .zero) {
        Spacer()
        ForEach(indices, id: \.self) { index in
          Image(systemName: getImageName(at: index))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: .s5)
            .padding(.horizontal, .s4)
            .foregroundColor(passcodeState.color)
        }
        Spacer()
      }
    )
  }
  
  func finishSetPin(_ completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion?()
      pin = ""
      isDisabled = false
      passcodeState = .standart
      self.helperText = nil
    }
  }
  
  func submitPin() {
    guard !pin.isEmpty else {
      return
    }
    
    if pin.count == maxDigits {
      isDisabled = true
      
      handler(pin) { isSuccess, helperText, completion  in
        if isSuccess {
          self.helperText = helperText
          passcodeState = .success
          finishSetPin(completion)
          triggerHapticFeedback(.success)
        } else {
          self.helperText = helperText
          passcodeState = .failure
          finishSetPin(completion)
          triggerHapticFeedback(.error)
        }
      }
      return
    }
    
    if pin.count > maxDigits {
      pin = String(pin.prefix(maxDigits))
      submitPin()
    }
  }
  
  func getImageName(at index: Int) -> String {
    if index >= self.pin.count {
      return Constants.circle
    }
    return Constants.circleFill
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
  static let circle = "circle"
  static let circleFill = "circle.fill"
}

// MARK: - Preview

struct PasscodeView_Previews: PreviewProvider {
  static var previews: some View {
    PasscodeFieldView(
      title: .constant("Pass Code"),
      pin: .constant("2"),
      maxDigits: 4
    ) { pin, isSuccess in
      isSuccess(true, "Helper text", {})
    }
    .background(Color.black)
  }
}
