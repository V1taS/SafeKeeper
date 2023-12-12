//
//  TitleAndSubtitleView.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle

public struct TitleAndSubtitleView: View {
  
  // MARK: - Private properties
  
  private let model: TitleAndSubtitleView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания заголовка и подзаголовка
  /// - Parameters:
  ///   - model: Модель данных
  public init(model: TitleAndSubtitleView.Model) {
    self.model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(alignment: model.alignment, spacing: .zero) {
      // Заголовок
      if case let .title(text, lineLimit, isSelectable, isSecure, action) = model.title {
        TapGestureView(
          content: getTitleView(
            with: isSecure,
            text: text,
            lineLimit: lineLimit
          ),
          style: .animationZoomOut,
          isEnabled: .constant(isSelectable),
          touchesEnded: {
            action?()
          }
        )
      }
      
      // Описание
      if case let .description(text, lineLimit, isSelectable, isSecure, action) = model.description {
        TapGestureView(
          content: Text(isSecure ? Constants.secureText : text)
            .font(.fancy.b1)
            .foregroundColor(.fancy.constant.slate)
            .lineLimit(lineLimit)
            .truncationMode(.middle)
            .multilineTextAlignment(.center),
          style: .animationZoomOut,
          isEnabled: .constant(isSelectable),
          touchesEnded: {
            action?()
          }
        )
        .padding(.top, .s2)
      }
    }
  }
}

// MARK: - Model

private extension TitleAndSubtitleView {
  func getTitleView(with isSecure: Bool, text: String, lineLimit: Int) -> AnyView {
    if isSecure {
      return AnyView(
        Image(systemName: "lock.circle")
          .resizable()
          .frame(width: .s11, height: .s11)
          .foregroundColor(.fancy.constant.ghost)
      )
    } else {
      return AnyView(
        Text(isSecure ? Constants.secureText : text)
          .font(model.style.fontTitle)
          .foregroundColor(.fancy.constant.ghost)
          .lineLimit(lineLimit)
          .truncationMode(.tail)
          .multilineTextAlignment(.center)
      )
    }
  }
}

// MARK: - Model

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
  public enum Title {
    case title(
      text: String,
      lineLimit: Int,
      isSelectable: Bool,
      isSecure: Bool,
      action: (() -> Void)?
    )
  }
  public enum Description {
    case description(
      text: String,
      lineLimit: Int,
      isSelectable: Bool,
      isSecure: Bool,
      action: (() -> Void)?
    )
  }
  
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

// MARK: - Constants

private enum Constants {
  static let secureText = "* * *"
}

// MARK: - Preview

struct TitleAndSubtitleView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      VStack {
        HStack{
          Spacer()
        }
        Spacer()
        TitleAndSubtitleView(
          model: .init(
            .title(
              text: "$ 153,04",
              lineLimit: 1,
              isSelectable: true,
              isSecure: true,
              action: {}
            ),
            .description(
              text: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
              lineLimit: 1,
              isSelectable: true,
              isSecure: false,
              action: {}),
            alignment: .center,
            style: .large
          )
        )
        Spacer()
      }
      
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
