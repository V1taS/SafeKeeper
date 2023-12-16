//
//  MainScreenView.swift
//  SafeKeeper
//
//  Created by Vitalii Sosin on 16.12.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import FancyKit
import FancyStyle

struct MainScreenView: View {
  
  // MARK: - Private properties
  
  private let store: StoreOf<MainScreenFeature>
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - value: Значение с клавиатуры
  ///   - isEnabled: Клавиатура включена
  init(store: StoreOf<MainScreenFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationCustomView(navigationTitle: "Wallet") {
        VStack(spacing: .zero) {
          ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: .zero) {
              createTitleAndSubtitleView()
                .padding(.top, .s10)
              
              createButtonPanelView()
                .padding(.top, .s5)
            }
            .padding(.horizontal, .s4)
          }
          
          createSetupWalletButtonView()
            .padding(.horizontal, .s4)
            .padding(.bottom, .s4)
        }
      }
    }
  }
}

// MARK: - Private

private extension MainScreenView {
  func createTitleAndSubtitleView() -> AnyView {
    AnyView(
      TitleAndSubtitleView(
        .title(
          text: "$ 0",
          lineLimit: 1,
          isSelectable: true,
          isSecure: false,
          action: {}
        ),
        .description(
          text: nil,
          lineLimit: 1,
          isSelectable: true,
          isSecure: false,
          action: {}),
        alignment: .center,
        style: .large
      )
    )
  }
  
  func createButtonPanelView() -> AnyView {
    AnyView(
      HStack {
        Spacer()
        CircleButtonView(
          text: "Send",
          type: .send,
          size: .small,
          action: {}
        )
        CircleButtonView(
          text: "Receive",
          type: .receive,
          size: .small,
          action: {}
        )
        Spacer()
      }
    )
  }
  
  func createSetupWalletButtonView() -> AnyView {
    AnyView(
      MainButtonView(
        text: .constant("Set up wallet"),
        isEnabled: .constant(true),
        style: .primary,
        action: {}
      )
    )
  }
}

// MARK: - Constants

private enum Constants {}

// MARK: - Preview

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView(
      store: Store(initialState: MainScreenFeature.State()) {
        MainScreenFeature()
      }
    )
  }
}
