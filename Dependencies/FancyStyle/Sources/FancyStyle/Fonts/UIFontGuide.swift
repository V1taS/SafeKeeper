//
//  UIFontGuide.swift
//
//  Created by Vitalii Sosin on 01.05.2022.
//

import UIKit

/// Гайд по шрифтам в приложении
public struct UIFontGuide {
  // MARK: - Medium
  
  /// Medium 32
  public let h1 = UIFont.get(font: .h1)
  
  /// Medium 22
  public let h2 = UIFont.get(font: .h2)
  
  /// Medium 19
  public let h3 = UIFont.get(font: .h3)
  
  /// Medium 17
  public let b1Medium = UIFont.get(font: .b1Medium)
  
  /// Medium 15
  public let b2Medium = UIFont.get(font: .b2Medium)
  
  /// Medium 13
  public let b3Medium = UIFont.get(font: .b3Medium)
  
  // MARK: - Regular
  
  /// Regular 36
  public let largeTitle = UIFont.get(font: .largeTitle)
  
  /// Regular 17
  public let b1 = UIFont.get(font: .b1)
  
  /// Regular 15
  public let b2 = UIFont.get(font: .b2)
  
  /// Regular 13
  public let b3 = UIFont.get(font: .b3)
}
