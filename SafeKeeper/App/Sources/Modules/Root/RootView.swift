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
  
  @State private var inputViewOne = ""
  @State private var inputViewTwo = ""
  @State private var inputViewThree = ""
  @State private var isErrorThree = true
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      //      Button("Количество нажатий - \(viewStore.count)") {
      //        viewStore.send(.incrementButtonTapped)
      //      }
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 16) {
          TitleAndSubtitleView(
            titleText: "$ 153,04",
            SubtitleText: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
            isEnabled: .constant(true),
            action: {
              
            }
          )
          .padding(.bottom)
          
          Group {
            InputView(
              text: $inputViewOne,
              placeholder: "Input view one",
              style: .none,
              keyboardType: .default,
              isEnabled: .constant(true),
              maxLength: 7,
              isError: .constant(false)
            )
            
            InputView(
              text: $inputViewTwo,
              placeholder: "Input view two",
              style: .leftHelper(text: "22:"),
              keyboardType: .numberPad,
              isEnabled: .constant(true),
              maxLength: 20,
              isError: .constant(false)
            )
            
            InputView(
              text: $inputViewThree,
              placeholder: "Input view three",
              style: .topHelper(text: "Comments"),
              keyboardType: .default,
              isEnabled: .constant(true),
              maxLength: 10,
              isError: $isErrorThree
            )
          }
          
          Group {
            HStack {
              Spacer()
              CircleButtonView(
                text: "Send",
                style: .send,
                isEnabled: .constant(true),
                action: {}
              )
              
              CircleButtonView(
                text: "Receive",
                style: .receive,
                isEnabled: .constant(true),
                action: {}
              )
              Spacer()
            }
          }
          .padding(.top)
          
          Group {
            WidgetCryptocurrencyView(models: .constant([
              .init(
                name: "Toncoin",
                imageData: Constants.mockImageData,
                totalCrypto: "62,93",
                totalCurrency: "152 $",
                currentPriceCryptoInCurrency: "2,41 $",
                isSelectable: true,
                action: {}
              ),
              .init(
                name: "Bitcoin",
                imageData: Constants.mockImageData,
                totalCrypto: "30,93",
                totalCurrency: "52 $",
                currentPriceCryptoInCurrency: "1,41 $",
                isSelectable: true,
                action: {}
              ),
              .init(
                name: "Bitcoin",
                imageData: Constants.mockImageData,
                totalCrypto: "30,93",
                totalCurrency: "52 $",
                currentPriceCryptoInCurrency: "1,41 $",
                isSelectable: true,
                action: {}
              ),
              .init(
                name: "Bitcoin",
                imageData: Constants.mockImageData,
                totalCrypto: "30,93",
                totalCurrency: "52 $",
                currentPriceCryptoInCurrency: "1,41 $",
                isSelectable: false,
                action: {}
              )
            ]))
          }
          .padding(.top)
          
          Group {
            VStack {
              MainButtonView(
                text: "Кнопка primary",
                style: .primary,
                isEnabled: .constant(true),
                action: {}
              )
              
              MainButtonView(
                text: "Кнопка secondary",
                style: .secondary,
                isEnabled: .constant(true),
                action: {}
              )
            }
          }
          .padding(.top)
          Spacer()
        }
        .padding(.top, .s26)
      }
      .padding(.horizontal)
      .background(Color.fancy.constant.onyx)
      .ignoresSafeArea(.all)
      .gesture(TapGesture()
        .onEnded { _ in
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
      )
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

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
  static let mockImageData: Data = UIImage(systemName: "link.circle")?.pngData() ?? Data()
}
