//
//  AppMain.swift
//  SafeKeeper
//
//  Created by Vitalii Sosin on 19.08.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct AppMain: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        MainScreenView(
          store: Store(initialState: MainScreenFeature.State()) {
            MainScreenFeature()
          }
        )
      }
    }
  }
}
