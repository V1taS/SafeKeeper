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
  
  @Binding private var isEnabled: Bool
  private let titleText: String
  private let SubtitleText: String
  private let action: () -> Void
  
  // MARK: - Initialization
  
  /// Инициализатор для создания заголовка и подзаголовка
  /// - Parameters:
  ///   - titleText: Основной текст
  ///   - SubtitleText: Дополнительный текст снизу
  ///   - isEnabled: Нажатие на SubtitleText включено
  ///   - action: Замыкание, которое будет выполняться при нажатии на SubtitleText
  public init(titleText: String,
              SubtitleText: String,
              isEnabled: Binding<Bool> = .constant(true),
              action: @escaping () -> Void) {
    self.titleText = titleText
    self.SubtitleText = SubtitleText
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(spacing: .zero) {
      Text(titleText)
        .font(.fancy.h1)
        .foregroundColor(.fancy.constant.ghost)
        .lineLimit(Constants.lineLimit)
        .truncationMode(.tail)
        .allowsHitTesting(false)
      
      TapGestureView(
        content: Text(SubtitleText)
          .font(.fancy.b1)
          .foregroundColor(.fancy.constant.slate)
          .lineLimit(Constants.lineLimit)
          .truncationMode(.middle),
        style: .animationZoomOut,
        isEnabled: $isEnabled,
        touchesEnded: {
          
        }
      )
      .padding(.top, .s2)
    }
  }
}

// MARK: - Private

private extension TitleAndSubtitleView {
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
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
          SubtitleText: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
          isEnabled: .constant(true),
          action: {}
        )
        Spacer()
      }
      
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
