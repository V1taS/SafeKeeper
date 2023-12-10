//
//  RoundedColorEdge.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI

public struct RoundedColorEdge: ViewModifier {
  let backgroundColor: Color
  let boarderColor: Color
  
  public func body(content: Content) -> some View {
    content
      .padding(.horizontal, .s3)
      .padding(.vertical, .s2)
      .background(backgroundColor)
      .cornerRadius(.s4)
      .overlay(RoundedRectangle(cornerRadius: .s4)
        .stroke(boarderColor))
  }
}

// MARK: - RoundedEdge

extension View {
  func roundedEdge(backgroundColor: Color, boarderColor: Color = .clear) -> some View {
    self.modifier(RoundedColorEdge(backgroundColor: backgroundColor, boarderColor: boarderColor))
  }
}

// MARK: - Preview

struct RoundedColorEdge_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      HStack {
        Color.fancy.constant.onyx
      }
      
      VStack {
        Text("Copy")
          .roundedEdge(
            backgroundColor: .fancy.constant.ruby,
            boarderColor: .clear
          )
      }
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
