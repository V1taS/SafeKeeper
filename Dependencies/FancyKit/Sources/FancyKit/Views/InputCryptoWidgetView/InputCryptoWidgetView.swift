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
  
  @Binding private var model: InputCryptoWidgetView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания виджета с криптовалютой
  /// - Parameters:
  ///   - model: Модель данных
  public init(model: Binding<InputCryptoWidgetView.Model>) {
    self._model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    createExchangeWidgetCrypto(model: model)
      .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension InputCryptoWidgetView {
  func createExchangeWidgetCrypto(model: InputCryptoWidgetView.Model) -> AnyView {
    AnyView(
      VStack(alignment: .center, spacing: .zero) {
        
        Text(model.crypto.value)
          .font(.fancy.h3)
          .foregroundColor(.fancy.constant.ghost)
          .lineLimit(Constants.lineLimit)
          .truncationMode(.tail)
          .allowsHitTesting(false)
      }
        .background(Color.fancy.constant.navy)
    )
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
}

// MARK: - Preview

struct InputCryptoWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      InputCryptoWidgetView(model:
          .constant(
            InputCryptoWidgetView.Model(
              .currency(
                name: "USD",
                value: "270.15"
              ),
              .crypto(
                name: "TON",
                value: "112"
              ),
              showType: .standart
            )
          )
      )
    }
    .padding(.top, .s26)
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
