//
//  NavigationCustomView.swift
//
//
//  Created by Vitalii Sosin on 16.12.2023.
//

import SwiftUI

public struct NavigationCustomView<Content: View>: View {
  
  // MARK: - Private properties
  
  private let navigationTitle: String?
  private let navigationDisplayMode: NavigationBarItem.TitleDisplayMode
  private let navigationBackgroundVisibility: Visibility
  private let navigationContent: (() -> Content)?
  
  private let content: () -> Content
  private let backgroundContent: Color?
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///   - navigationTitle: Текст заголовка
  ///   - navigationDisplayMode: Большой или маленький заголовок
  ///   - navigationBackgroundVisibility: Фон у навигейшен бара
  ///   - navigationContent: Контент в навигейшен баре
  ///   - content: Контент
  ///   - backgroundContent: Цвет фона для контента
  public init(
    navigationTitle: String?,
    navigationDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
    navigationBackgroundVisibility: Visibility = .visible,
    navigationContent: (() -> Content)? = nil,
    content: @escaping () -> Content,
    backgroundContent: Color? = nil
  ) {
    self.navigationTitle = navigationTitle
    self.navigationDisplayMode = navigationDisplayMode
    self.navigationBackgroundVisibility = navigationBackgroundVisibility
    self.navigationContent = navigationContent
    self.content = content
    self.backgroundContent = backgroundContent
  }
  
  public var body: some View {
    content()
      .background((backgroundContent ?? Color.fancy.constant.onyx).edgesIgnoringSafeArea(.all))
      .navigationBarTitleDisplayMode(navigationDisplayMode)
      .toolbarBackground(backgroundContent ?? Color.fancy.constant.onyx, for: .navigationBar)
      .toolbarBackground(navigationBackgroundVisibility)
      .toolbar {
        if let navigationTitle {
          ToolbarItem(placement: .principal) {
            Text(navigationTitle)
              .font(.fancy.h3)
              .fontWeight(.bold)
              .foregroundColor(.fancy.constant.ghost)
          }
        } else if let navigationContent {
          ToolbarItem(placement: .principal) {
            navigationContent()
          }
        }
      }
  }
}
