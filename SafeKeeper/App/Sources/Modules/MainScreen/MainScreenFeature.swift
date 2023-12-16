//
//  MainScreenFeature.swift
//  SafeKeeper
//
//  Created by Vitalii Sosin on 16.12.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import ComposableArchitecture

struct MainScreenFeature: Reducer {
  
  // MARK: - State
  
  struct State: Equatable {}
  
  // MARK: - Action
  
  enum Action {}
  
  // MARK: - Dependency
  
  @Dependency(\.dataManager.save) var saveData
  
  // MARK: - Reduce
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    .none
  }
}
