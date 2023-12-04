//
//  RootView.swift
//  SafeKeeper
//
//  Created by Vitalii Sosin on 19.08.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import FancyKit
import FancyStyle

struct RootView: View {
  let store: StoreOf<RootFeature>
  
  @State var text1: String = ""
  @State var text2: String = ""
  @State var text3: String = ""
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      //      Button("Количество нажатий - \(viewStore.count)") {
      //        viewStore.send(.incrementButtonTapped)
      //      }
      
      VStack(spacing: 16) {
        Spacer()
        InputView(text: $text1, placeholder: "Placeholder", style: .none, isEnabled: .constant(true))
        InputView(text: $text2, placeholder: "Placeholder", style: .leftHelper(text: "22:"), isEnabled: .constant(true))
        InputView(text: $text3, placeholder: "Placeholder", style: .topHelper(text: "Comments"), isEnabled: .constant(true))
        Spacer()
      }
      .padding(.horizontal)
      .background(Color.fancy.constant.onyx)
      .ignoresSafeArea(.all)
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView(
      store: Store(initialState: RootFeature.State()) {
        RootFeature()
      }
    )
  }
}
