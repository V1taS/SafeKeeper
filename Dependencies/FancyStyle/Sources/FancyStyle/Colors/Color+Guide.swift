//
//  Color+Guide.swift
//  FancyStyle
//
//  Created by Vitalii Sosin on 09.09.2023.
//

import SwiftUI

/// Расширение для `Color`
public extension Color {
  
  /// Список цветов `Fancy`
  static var fancy: ColorGuide { colorGuide }
}

// MARK: - Public property

public var fancyColor: ColorGuide { colorGuide }

// MARK: - Private property

private let colorGuide = ColorGuide(dynamic: ColorGuide.Dynamic(), constant: ColorGuide.Constant())
