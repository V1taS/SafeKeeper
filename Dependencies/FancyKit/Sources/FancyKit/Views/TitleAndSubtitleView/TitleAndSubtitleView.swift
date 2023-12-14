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
          .init(
            content: AnyView(
              getTitleView(
                with: isSecure,
                text: text,
                lineLimit: lineLimit
              )
            ),
            style: .animationZoomOut,
            touchesEnded: {
              action?()
            }
          )
        )
      }
      
      // Описание
      if case let .description(text, lineLimit, isSelectable, isSecure, action) = model.description {
        TapGestureView(
          .init(
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
          .font(model.style.fontTitle)
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
