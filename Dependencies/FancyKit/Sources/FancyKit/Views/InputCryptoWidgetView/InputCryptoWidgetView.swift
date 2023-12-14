//
//  InputCryptoWidgetView.swift
//
//
//  Created by Vitalii Sosin on 12.12.2023.
//

import SwiftUI
import FancyStyle

public struct InputCryptoWidgetView: View {
  
  // MARK: - Private properties
  
  @Binding private var model: InputCryptoWidgetView.Model
  
  // MARK: - Initialization
  
  /// Инициализатор для создания виджета с криптовалютой
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: Binding<InputCryptoWidgetView.Model>) {
    self._model = model
  }
  
  // MARK: - Body
  
  public var body: some View {
    createExchangeWidgetCrypto(model: model)
      .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension InputCryptoWidgetView {
  func createExchangeWidgetCrypto(model: InputCryptoWidgetView.Model) -> AnyView {
    AnyView(
      ZStack {
        Color.fancy.constant.navy
        
        VStack(alignment: .center, spacing: .zero) {
          HStack {
            Spacer()
            CircleButtonView(
              .init(
                type: .custom(systemNameImage: "arrow.up.arrow.down"),
                size: .small,
                style: .custom(color: .fancy.constant.ghost.opacity(0.1)),
                action: {
                  model.flipAction()
                }
              )
            )
            .foregroundColor(Color.fancy.constant.ghost)
          }
          .padding(.top, .s4)
          .padding(.trailing, .s4)
          
          Spacer()
          
          HStack(alignment: .bottom, spacing: .s2) {
            Text(model.crypto.value)
              .font(.fancy.largeTitle)
              .fontWeight(.bold)
              .foregroundColor(.fancy.constant.ghost)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
              .allowsHitTesting(false)
            
            Text(model.crypto.name)
              .font(.fancy.h1)
              .fontWeight(.semibold)
              .foregroundColor(.fancy.constant.slate)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
              .allowsHitTesting(false)
          }
          
          Text("\(model.currency.value) \(model.currency.name)")
            .font(.fancy.h3)
            .foregroundColor(.fancy.constant.slate)
            .lineLimit(Constants.lineLimit)
            .truncationMode(.tail)
            .allowsHitTesting(false)
            .roundedEdge(
              backgroundColor: .clear,
              boarderColor: .fancy.constant.slate
            )
            .padding(.top, .s3)
          
          Spacer()
        }
      }
    )
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
}

// MARK: - Preview

struct InputCryptoWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      HStack{ Spacer() }
      InputCryptoWidgetView(
        .constant(
          .init(
            .constant(.init(value: .constant("270.15"), name: "USD")),
            .constant(.init(value: .constant("112"), name: "TON")),
            showType: .constant(.standart),
            maxLength: 100,
            flipAction: {}
          )
        )
      )
      .padding()
      Spacer()
    }
    .padding(.vertical, .s26)
    .padding(.horizontal, .s4)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
