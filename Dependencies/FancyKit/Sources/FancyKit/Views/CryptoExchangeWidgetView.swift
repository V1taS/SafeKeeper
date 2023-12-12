//
//  CryptoExchangeWidgetView.swift
//
//
//  Created by Vitalii Sosin on 12.12.2023.
//

import SwiftUI
import FancyStyle

public struct CryptoExchangeWidgetView: View {
  
  // MARK: - Private properties
  
  @Binding private var model: CryptoExchangeWidgetView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания виджета с криптовалютой
  /// - Parameters:
  ///   - model: Модель данных
  public init(model: Binding<CryptoExchangeWidgetView.Model>) {
    self._model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    createExchangeWidgetCrypto(model: model)
      .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension CryptoExchangeWidgetView {
  func createExchangeWidgetCrypto(model: CryptoExchangeWidgetView.Model) -> AnyView {
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

// MARK: - Model

extension CryptoExchangeWidgetView {
  public enum CurrencyType {
    /// Имя валюты
    public var name: String {
      switch self {
      case let .currency(name, _):
        return name
      }
    }
    
    /// Значение валюты
    public var value: String {
      switch self {
      case let .currency(_, value):
        return value
      }
    }
    
    /// Валюта
    case currency(name: String, value: String)
  }
  
  public enum CryptoType {
    /// Имя криптовалюты
    public var name: String {
      switch self {
      case let .crypto(name, _):
        return name
      }
    }
    
    /// Значение криптовалюты
    public var value: String {
      switch self {
      case let .crypto(_, value):
        return value
      }
    }
    
    /// Криптовалюта
    case crypto(name: String, value: String)
  }
  
  public enum ShowType {
    /// Стандартный показ (Криптовалюта сверху)
    case standart
    
    /// Перевернутый показ (Криптовалюта снизу)
    case reverse
  }
  
  public struct Model: Identifiable {
    /// ID для модельки
    public let id = UUID()
    
    /// Валюта
    public let currency: CryptoExchangeWidgetView.CurrencyType
    
    /// Криптовалюта
    public let crypto: CryptoExchangeWidgetView.CryptoType
    
    /// Тип показа данных
    public let showType: CryptoExchangeWidgetView.ShowType
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки для виджета
    /// - Parameters:
    ///   - currency: Валюта
    ///   - crypto: Криптовалюта
    ///   - showType: Тип показа данных
    public init(_ currency: CryptoExchangeWidgetView.CurrencyType,
                _ crypto: CryptoExchangeWidgetView.CryptoType,
                showType: CryptoExchangeWidgetView.ShowType) {
      self.currency = currency
      self.crypto = crypto
      self.showType = showType
    }
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
}

// MARK: - Preview

struct CryptoExchangeWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      CryptoExchangeWidgetView(model:
          .constant(
            CryptoExchangeWidgetView.Model(
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
