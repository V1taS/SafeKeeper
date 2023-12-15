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
  
  private let title: TitleAndSubtitleView.Title
  private let description: TitleAndSubtitleView.Description
  private let alignment: HorizontalAlignment
  private let style: TitleAndSubtitleView.Style
  
  // MARK: - Initialization
  
  /// Инициализатор
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
  
  // MARK: - Body
  
  public var body: some View {
    VStack(alignment: alignment, spacing: .zero) {
      // Заголовок
      if case let .title(text, lineLimit, isSelectable, isSecure, action) = title {
        TapGestureView(
          content: AnyView(
            getTitleView(
              with: isSecure,
              text: text,
              lineLimit: lineLimit
            )
          ),
          style: .animationZoomOut,
          isSelectable: isSelectable,
          touchesEnded: {
            action?()
          }
        )
      }
      
      // Описание
      if case let .description(text, lineLimit, isSelectable, isSecure, action) = description {
        TapGestureView(
          content: AnyView(
            Text(isSecure ? Constants.secureText : text)
              .font(.fancy.b1)
              .foregroundColor(.fancy.constant.slate)
              .lineLimit(lineLimit)
              .truncationMode(.middle)
              .multilineTextAlignment(.center)
          ),
          style: .animationZoomOut,
          isSelectable: isSelectable,
          touchesEnded: {
            action?()
          }
        )
        .padding(.top, .s2)
      }
    }
  }
}

// MARK: - Private

private extension TitleAndSubtitleView {
  func getTitleView(with isSecure: Bool, text: String, lineLimit: Int) -> AnyView {
    if isSecure {
      return AnyView(
        Image(systemName: "lock.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: .s11, height: .s11)
          .foregroundColor(.fancy.constant.ghost)
      )
    } else {
      return AnyView(
        Text(isSecure ? Constants.secureText : text)
          .font(style.fontTitle)
          .foregroundColor(.fancy.constant.ghost)
          .lineLimit(lineLimit)
          .truncationMode(.tail)
          .multilineTextAlignment(.center)
      )
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
        Spacer()
      }
      
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
