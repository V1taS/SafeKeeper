//
//  TitleAndSubtitleView.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle

public struct TitleAndSubtitleView: View {
  
  // MARK: - Style
  
  public enum Style {
    
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
  
  // MARK: - Private properties
  
  private let style: Style
  @Binding private var isEnabled: Bool
  private let titleText: String
  private let subtitleText: String
  private let action: () -> Void
  private let lineLimitTitle: Int
  private let lineLimitSubtitle: Int
  private let alignment: HorizontalAlignment
  
  // MARK: - Initialization
  
  /// Инициализатор для создания заголовка и подзаголовка
  /// - Parameters:
  ///   - titleText: Основной текст
  ///   - SubtitleText: Дополнительный текст снизу
  ///   - isEnabled: Нажатие на SubtitleText включено
  ///   - lineLimitTitle: Ограничение строк у заголовка
  ///   - lineLimitSubtitle: Ограничение строк у подзаголовка
  ///   - action: Замыкание, которое будет выполняться при нажатии на SubtitleText
  public init(titleText: String,
              subtitleText: String,
              style: TitleAndSubtitleView.Style = .standart,
              isEnabled: Binding<Bool> = .constant(true),
              lineLimitTitle: Int = 1,
              lineLimitSubtitle: Int = 1,
              alignment: HorizontalAlignment = .center,
              action: @escaping () -> Void) {
    self.titleText = titleText
    self.subtitleText = subtitleText
    self.style = style
    self._isEnabled = isEnabled
    self.lineLimitTitle = lineLimitTitle
    self.lineLimitSubtitle = lineLimitSubtitle
    self.alignment = alignment
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(alignment: alignment, spacing: .zero) {
      Text(titleText)
        .font(style.fontTitle)
        .foregroundColor(.fancy.constant.ghost)
        .lineLimit(lineLimitTitle)
        .truncationMode(.tail)
        .allowsHitTesting(false)
        .multilineTextAlignment(.center)
      
      TapGestureView(
        content: Text(subtitleText)
          .font(.fancy.b1)
          .foregroundColor(.fancy.constant.slate)
          .lineLimit(lineLimitSubtitle)
          .truncationMode(.middle)
          .multilineTextAlignment(.center),
        style: .animationZoomOut,
        isEnabled: $isEnabled,
        touchesEnded: {
          action()
        }
      )
      .padding(.top, .s2)
    }
  }
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
          titleText: "$ 153,04",
          subtitleText: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
          style: .large,
          isEnabled: .constant(true),
          lineLimitTitle: 1,
          lineLimitSubtitle: 1,
          alignment: .center,
          action: {}
        )
        Spacer()
      }
      
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
