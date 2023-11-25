//
//  UIFont+Guide.swift
//
//  Created by Vitalii Sosin on 01.05.2022.
//

import SwiftUI

/// Расширение для `UIFont`
public extension UIFont {
  
  /// Список шрифтов
  class var fancy: UIFontGuide { UIFontGuide() }
}

/// Расширение для `Font`
public extension Font {
  
  /// Список шрифтов
  static var fancy: FontGuide { FontGuide() }
}
