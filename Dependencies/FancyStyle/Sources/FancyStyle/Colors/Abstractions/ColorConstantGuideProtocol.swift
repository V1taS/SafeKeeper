//
//  ColorConstantGuideProtocol.swift
//  FancyStyle
//
//  Created by Vitalii Sosin on 09.09.2023.
//

import Foundation

protocol ColorConstantGuideProtocol {
  associatedtype ColorType
  
  /// Очень темно-синий цвет
  var onyx: ColorType { get }
  
  /// Темно-синий цвет
  var navy: ColorType { get }
  
  /// Серый цвет
  var slate: ColorType { get }
  
  /// Белый цвет
  var ghost: ColorType { get }
  
  /// Красный цвет
  var ruby: ColorType { get }
  
  /// Зеленый цвет
  var lime: ColorType { get }
  
  /// Синий цвет
  var azure: ColorType { get }
}
