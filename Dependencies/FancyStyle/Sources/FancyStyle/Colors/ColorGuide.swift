//
//  ColorGuide.swift
//  FancyStyle
//
//  Created by Vitalii Sosin on 09.09.2023.
//

import SwiftUI

/// Гайд по цветам в приложении, для светлой и темной темы
public struct ColorGuide {
  
  /// Цвета для темной и светлой темы
  public let dynamic: Dynamic
  
  /// Только определенный цвет
  public let constant: Constant
  
  // MARK: - Constant
  
  /// Только конкретный цвет
  public struct Constant: ColorConstantGuideProtocol {
    /// Очень темно-синий цвет
    public let onyx = Color(UIColor(hexString: ColorToken.onyx.hexString))
    
    /// Темно-синий цвет
    public let navy = Color(UIColor(hexString: ColorToken.navy.hexString))
    
    /// Серый цвет
    public let slate = Color(UIColor(hexString: ColorToken.slate.hexString))
    
    /// Белый цвет
    public let ghost = Color(UIColor(hexString: ColorToken.ghost.hexString))
    
    /// Красный цвет
    public let ruby = Color(UIColor(hexString: ColorToken.ruby.hexString))
    
    /// Зеленый цвет
    public let lime = Color(UIColor(hexString: ColorToken.lime.hexString))
    
    /// Синий цвет
    public let azure = Color(UIColor(hexString: ColorToken.azure.hexString))
  }
  
  // MARK: - Dynamic
  
  /// Темная и светлая тема
  public struct Dynamic: ColorDynamicGuideProtocol {
    typealias ColorType = Color
  }
}
