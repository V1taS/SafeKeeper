//
//  TitleAndSubtitleView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import SwiftUI

// MARK: - Model

extension TitleAndSubtitleView {
  public struct Model: Identifiable {
    /// ID для модельки
    public let id = UUID()
    
    /// Заголовок
    public let title: TitleAndSubtitleView.Title
    
    /// Описание
    public let description: TitleAndSubtitleView.Description
    
    /// Выравнивание всего контента
    public var alignment: HorizontalAlignment = .center
    /// Стиль
    public var style: TitleAndSubtitleView.Style = .large
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки
    /// - Parameters:
    ///   - title: Заголовок
    ///   - description: Описание
    ///   - alignment: Выравнивание всего контента
    ///   - style: Стиль
    public init(
      _ title: TitleAndSubtitleView.Title,
      _ description: TitleAndSubtitleView.Description,
      alignment: HorizontalAlignment = .center,
      style: TitleAndSubtitleView.Style = .large
    ) {
      self.title = title
      self.description = description
      self.alignment = alignment
      self.style = style
    }
  }
}

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
