//
//  InputCryptoWidgetView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Model

extension InputCryptoWidgetView {
  public struct Model: Identifiable {
    /// ID для модельки
    public let id = UUID()
    
    /// Валюта
    @Binding public var currency: InputCryptoWidgetView.Currency
    
    /// Криптовалюта
    @Binding public var crypto: InputCryptoWidgetView.Crypto
    
    /// Тип показа данных
    @Binding public var showType: InputCryptoWidgetView.ShowType
    
    /// Максимальная длина символов
    public let maxLength: Int
    
    /// Перевернуть значения
    public let flipAction: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки для виджета
    /// - Parameters:
    ///   - currency: Валюта
    ///   - crypto: Криптовалюта
    ///   - showType: Тип показа данных
    ///   - maxLength: Максимальная длина символов
    ///   - flipAction: Перевернуть значения
    public init(_ currency: Binding<InputCryptoWidgetView.Currency>,
                _ crypto: Binding<InputCryptoWidgetView.Crypto>,
                showType: Binding<InputCryptoWidgetView.ShowType>,
                maxLength: Int = 100,
                flipAction: @escaping () -> Void) {
      self._currency = currency
      self._crypto = crypto
      self._showType = showType
      self.maxLength = maxLength
      self.flipAction = flipAction
    }
  }
}

// MARK: - CurrencyType

extension InputCryptoWidgetView {
  public struct Currency {
    /// Значение валюты
    @Binding public var value: String
    /// Имя валюты
    public let name: String
    
    // MARK: - Initialization
    
    /// Инициализатор
    /// - Parameters:
    ///   - value: Значение валюты
    ///   - name: Имя валюты
    public init(value: Binding<String>, name: String) {
      self._value = value
      self.name = name
    }
  }
}

// MARK: - CryptoType

extension InputCryptoWidgetView {
  public struct Crypto {
    /// Значение криптовалюты
    @Binding public var value: String
    /// Имя криптовалюты
    public let name: String
    
    // MARK: - Initialization
    
    /// Инициализатор
    /// - Parameters:
    ///   - value: Значение криптовалюты
    ///   - name: Имя криптовалюты
    public init(value: Binding<String>, name: String) {
      self._value = value
      self.name = name
    }
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
