//
//  ColorToken.swift
//
//
//  Created by Vitalii Sosin on 01.05.2022.
//

import UIKit

/// Список цветов
public enum ColorToken: CaseIterable {
  
  /// Hex цвета
  public var hexString: String {
    switch self {
    case .onyx:
      return "10161F"
    case .navy:
      return "1D2633"
    case .slate:
      return "8792A1"
    case .ghost:
      return "F7F7F7"
    case .ruby:
      return "F74766"
    case .lime:
      return "3ACC83"
    case .azure:
      return "009FC7"
    }
  }
  
  /// Очень темно-синий цвет
  case onyx
  
  /// Темно-синий цвет
  case navy
  
  /// Серый цвет
  case slate
  
  /// Белый цвет
  case ghost
  
  /// Красный цвет
  case ruby
  
  /// Зеленый цвет
  case lime
  
  /// Синий цвет
  case azure
}
