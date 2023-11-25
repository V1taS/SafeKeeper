//
//  FontExample.swift
//
//
//  Created by Vitalii Sosin on 25.11.2023.
//

import SwiftUI

struct FontExample: View {
  var body: some View {
    VStack {
      ScrollView(showsIndicators: false) {
        ForEach(Constants.fonts, id: \.self) { item in
          Text("Шрифт: \(item.name)")
            .font(item.font)
            .padding(.bottom)
        }
      }
    }
    .padding(.top)
  }
}

// MARK: - Preview

#Preview {
  FontExample()
}

// MARK: - Constants

private enum Constants {
  static let fonts: [FontItem] = [
    FontItem(font: .fancy.largeTitle, name: "largeTitle"),
    FontItem(font: .fancy.h1, name: "h1"),
    FontItem(font: .fancy.h2, name: "h2"),
    FontItem(font: .fancy.h3, name: "h3"),
    FontItem(font: .fancy.b1Medium, name: "b1Medium"),
    FontItem(font: .fancy.b2Medium, name: "b2Medium"),
    FontItem(font: .fancy.b3Medium, name: "b3Medium"),
    FontItem(font: .fancy.b1, name: "b1"),
    FontItem(font: .fancy.b2, name: "b2"),
    FontItem(font: .fancy.b3, name: "b3")
  ]
}

// MARK: - FontItem

struct FontItem: Hashable {
  let font: Font
  let name: String
}
