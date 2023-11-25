//
//  ColorExample.swift
//
//
//  Created by Vitalii Sosin on 25.11.2023.
//

import SwiftUI

struct ColorExample: View {
  var body: some View {
    VStack {
      ScrollView(showsIndicators: false) {
        ForEach(Constants.colors, id: \.self) { item in
          Text("\(item.name)")
            .font(.fancy.largeTitle)
          
          Rectangle()
            .fill(item.color)
            .frame(width: 200, height: 200)
            .cornerRadius(16)
            .padding(.bottom)
        }
      }
    }
    .padding(.top)
  }
}

// MARK: - Preview

#Preview {
  ColorExample()
}

// MARK: - Constants

private enum Constants {
  static let colors: [ColorItem] = [
    ColorItem(color: .fancy.constant.onyx, name: "Onyx"),
    ColorItem(color: .fancy.constant.navy, name: "Navy"),
    ColorItem(color: .fancy.constant.slate, name: "Slate"),
    ColorItem(color: .fancy.constant.ghost, name: "Ghost"),
    ColorItem(color: .fancy.constant.ruby, name: "Ruby"),
    ColorItem(color: .fancy.constant.lime, name: "Lime"),
    ColorItem(color: .fancy.constant.azure, name: "Azure"),
  ]
}

// MARK: - ColorItem

struct ColorItem: Hashable {
  let color: Color
  let name: String
}
