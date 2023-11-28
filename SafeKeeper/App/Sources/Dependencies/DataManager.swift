//
//  DataManager.swift
//  SafeKeeper
//
//  Created by Vitalii Sosin on 28.11.2023.
//  Copyright © 2023 SosinVitalii.com. All rights reserved.
//

import Dependencies
import Foundation

// MARK: - DataManager

struct DataManager: Sendable {
  var load: @Sendable (URL) throws -> Data
  var save: @Sendable (Data, URL) async throws -> Void
}

// MARK: - DependencyKey

extension DataManager: DependencyKey {
  static let liveValue = Self(
    load: { url in try Data(contentsOf: url) },
    save: { data, url in try data.write(to: url) }
  )
  
  static let testValue = Self(
    load: unimplemented("DataManager.load"),
    save: unimplemented("DataManager.save")
  )
}

// MARK: - DependencyValues

extension DependencyValues {
  var dataManager: DataManager {
    get { self[DataManager.self] }
    set { self[DataManager.self] = newValue }
  }
}

// MARK: - DataManagerMock

extension DataManager {
  static func mock(initialData: Data? = nil) -> Self {
    let data = LockIsolated(initialData)
    return Self(
      load: { _ in
        guard let data = data.value
        else {
          struct FileNotFound: Error {}
          throw FileNotFound()
        }
        return data
      },
      save: { newData, _ in data.setValue(newData) }
    )
  }
  
  static let failToWrite = Self(
    load: { _ in Data() },
    save: { _, _ in
      struct SaveError: Error {}
      throw SaveError()
    }
  )
  
  static let failToLoad = Self(
    load: { _ in
      struct LoadError: Error {}
      throw LoadError()
    },
    save: { _, _ in }
  )
}
