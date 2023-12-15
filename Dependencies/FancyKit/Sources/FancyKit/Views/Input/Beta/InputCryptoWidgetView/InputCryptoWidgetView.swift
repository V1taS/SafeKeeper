//
//  InputCryptoWidgetView.swift
//
//
//  Created by Vitalii Sosin on 12.12.2023.
//

import SwiftUI
import FancyStyle

public struct InputCryptoWidgetView: View {
  
  // MARK: - Private properties
  
  @Binding private var currencyValue: String
  private let currencyName: String
  
  @Binding private var cryptoValue: String
  private let cryptoName: String
  
  @Binding private var presentWidgetType: InputCryptoWidgetView.PresentWidgetType
  private let maxLength: Int
  private let flipAction: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - currencyValue: Значение валюты
  ///   - currencyName: Имя валюты
  ///   - cryptoValue: Значение криптовалюты
  ///   - cryptoName: Имя криптовалюты
  ///   - presentWidgetType: Тип показа данных
  ///   - maxLength: Максимальная длина символов
  ///   - flipAction: Перевернуть значения
  public init(currencyValue: Binding<String>,
              currencyName: String,
              cryptoValue: Binding<String>,
              cryptoName: String,
              presentWidgetType: Binding<InputCryptoWidgetView.PresentWidgetType>,
              maxLength: Int = 20,
              flipAction: @escaping () -> Void) {
    self._currencyValue = currencyValue
    self.currencyName = currencyName
    self._cryptoValue = cryptoValue
    self.cryptoName = cryptoName
    self._presentWidgetType = presentWidgetType
    self.maxLength = maxLength
    self.flipAction = flipAction
  }
  
  // MARK: - Body
  
  public var body: some View {
    createExchangeWidgetCrypto()
      .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension InputCryptoWidgetView {
  func createExchangeWidgetCrypto() -> AnyView {
    AnyView(
      ZStack {
        Color.fancy.constant.navy
        
        VStack(alignment: .center, spacing: .zero) {
          HStack {
            Spacer()
            CircleButtonView(
              type: .custom(systemNameImage: "arrow.up.arrow.down"),
              size: .small,
              style: .custom(color: .fancy.constant.ghost.opacity(0.1)),
              action: {
                flipAction()
              }
            )
            .foregroundColor(Color.fancy.constant.ghost)
          }
          .padding(.top, .s4)
          .padding(.trailing, .s4)
          
          Spacer()
          
          HStack(alignment: .bottom, spacing: .s2) {
            InputContentSizeView(
              text: $cryptoValue
            )
            
            Text(cryptoName)
              .font(.fancy.h1)
              .fontWeight(.semibold)
              .foregroundColor(.fancy.constant.slate)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
              .allowsHitTesting(false)
          }
          
          Text("\(currencyValue) \(currencyName)")
            .font(.fancy.h3)
            .foregroundColor(.fancy.constant.slate)
            .lineLimit(Constants.lineLimit)
            .truncationMode(.tail)
            .allowsHitTesting(false)
            .roundedEdge(
              backgroundColor: .clear,
              boarderColor: .fancy.constant.slate
            )
            .padding(.top, .s3)
          
          Spacer()
        }
      }
    )
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
}

// MARK: - PresentWidgetType

extension InputCryptoWidgetView {
  public enum PresentWidgetType {
    /// Стандартный показ (Криптовалюта сверху)
    case standart
    
    /// Перевернутый показ (Криптовалюта снизу)
    case reverse
  }
}

// MARK: - Preview

struct InputCryptoWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      HStack{ Spacer() }
      InputCryptoWidgetView(
        currencyValue: .constant("270.15"),
        currencyName: "USD",
        cryptoValue: .constant("112"),
        cryptoName: "TON",
        presentWidgetType: .constant(.standart),
        flipAction: {}
      )
      .padding()
      Spacer()
    }
    .padding(.vertical, .s26)
    .padding(.horizontal, .s4)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
