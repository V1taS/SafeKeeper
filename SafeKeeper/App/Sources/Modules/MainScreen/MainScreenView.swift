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
      VStack(spacing: .zero) {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: .zero) {
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
            .padding(.top, .s10)
            
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
            .padding(.top, .s5)
          }
          .padding(.horizontal, .s4)
        }
        
        MainButtonView(
          text: .constant("Set up wallet"),
          isEnabled: .constant(true),
          style: .primary,
          action: {}
        )
        .padding(.horizontal, .s4)
        .padding(.bottom, .s4)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.fancy.constant.onyx.edgesIgnoringSafeArea(.all))
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(Color.fancy.constant.onyx, for: .navigationBar)
    .toolbarBackground(.visible)
    .toolbar {
      ToolbarItem(placement: .principal) {
        VStack {
          Text("Wallet")
            .font(.fancy.h3)
            .fontWeight(.bold)
            .foregroundColor(.fancy.constant.ghost)
        }
      }
    }
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
