//
//  TitleAndSubtitleView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Style

extension TitleAndSubtitleView {
  public enum Style {
    /// Шрифт заголовка
    var fontTitle: Font {
      switch self {
      case .large:
        return .fancy.h1
      case .standart:
        return .fancy.b1Medium
      }
    }
    /// Большой
    case large
    /// Стандартный
    case standart
  }
}

// MARK: - Title

extension TitleAndSubtitleView {
  public enum Title {
    case title(
      text: String,
      lineLimit: Int,
      isSelectable: Bool,
      isSecure: Bool,
      action: (() -> Void)?
    )
  }
}

// MARK: - Description

extension TitleAndSubtitleView {
  public enum Description {
    case description(
      text: String,
      lineLimit: Int,
      isSelectable: Bool,
      isSecure: Bool,
      action: (() -> Void)?
    )
  }
}
