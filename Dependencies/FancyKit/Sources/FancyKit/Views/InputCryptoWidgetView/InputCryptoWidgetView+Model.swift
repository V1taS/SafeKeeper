//
//  InputCryptoWidgetView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import Foundation

// MARK: - Model

extension InputCryptoWidgetView {
  public struct Model: Identifiable {
    /// ID для модельки
    public let id = UUID()
    
    /// Валюта
    public let currency: InputCryptoWidgetView.CurrencyType
    
    /// Криптовалюта
    public let crypto: InputCryptoWidgetView.CryptoType
    
    /// Тип показа данных
    public let showType: InputCryptoWidgetView.ShowType
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки для виджета
    /// - Parameters:
    ///   - currency: Валюта
    ///   - crypto: Криптовалюта
    ///   - showType: Тип показа данных
    public init(_ currency: InputCryptoWidgetView.CurrencyType,
                _ crypto: InputCryptoWidgetView.CryptoType,
                showType: InputCryptoWidgetView.ShowType) {
      self.currency = currency
      self.crypto = crypto
      self.showType = showType
    }
  }
}

// MARK: - CurrencyType

extension InputCryptoWidgetView {
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
}

// MARK: - CryptoType

extension InputCryptoWidgetView {
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
}

// MARK: - ShowType

extension InputCryptoWidgetView {
  public enum ShowType {
    /// Стандартный показ (Криптовалюта сверху)
    case standart
    
    /// Перевернутый показ (Криптовалюта снизу)
    case reverse
  }
}
