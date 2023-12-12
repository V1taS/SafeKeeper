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
          HStack {
            RoundButtonView(
              style: .copy(text: "Copy"),
              isEnabled: .constant(true),
              action: {}
            )
            
            RoundButtonView(
              style: .custom(image: nil, text: "Max"),
              isEnabled: .constant(true),
              action: {}
            )
          }
          .padding(.bottom)
          
          QRCodeView(
            dataString: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
            icon: UIImage(systemName: "link.circle")?.pngData()
          )
          .padding(.bottom)
          
          TitleAndSubtitleView(
            titleText: "$ 153,04",
            subtitleText: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
            style: .large,
            isEnabled: .constant(true),
            lineLimitTitle: 1,
            lineLimitSubtitle: 1,
            action: {}
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
            WidgetCryptoView(models: .constant([
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Toncoin",
                  description: "$2,31",
                  addition: "+0,29%",
                  additionStyle: .positive
                ),
                .rightSide(
                  isChevron: false,
                  title: "1 436,99",
                  titleStyle: .standart,
                  titleIsSecure: false,
                  description: "$3 325,48",
                  descriptionSecure: false
                ),
                additionText: nil,
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Toncoin",
                  description: "$2,31",
                  addition: "-3,29%",
                  additionStyle: .negative
                ),
                .rightSide(
                  isChevron: false,
                  title: "1 436,99",
                  titleStyle: .standart,
                  titleIsSecure: false,
                  description: "$3 325,48",
                  descriptionSecure: false
                ),
                additionText: nil,
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Toncoin",
                  description: "$2,31",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: false,
                  title: "1 436,99",
                  titleStyle: .standart,
                  titleIsSecure: false,
                  description: "$3 325,48",
                  descriptionSecure: false
                ),
                additionText: "Welcome to the TON DNS Club tondnsclub Welcome to the TON DNS Club",
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Toncoin",
                  description: "$2,31",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: false,
                  title: "1 436,99",
                  titleStyle: .standart,
                  titleIsSecure: false,
                  description: "$3 325,48",
                  descriptionSecure: false
                ),
                additionText: "Welcome to the TON DNS Club tondnsclub",
                additionContent: AnyView(
                  MainButtonView(text: "Some View HERE", action: {})
                ),
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: nil,
                  title: "Earn TON",
                  description: "APY up to 4.64%",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: true,
                  title: "",
                  titleStyle: .standart,
                  titleIsSecure: false,
                  description: "",
                  descriptionSecure: false
                ),
                additionText: nil,
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Received",
                  description: "$UQCK...Bauu",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: false,
                  title: "NFT",
                  titleStyle: .positive,
                  titleIsSecure: false,
                  description: "14 Jul, 07:25",
                  descriptionSecure: false
                ),
                additionText: nil,
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Bid",
                  description: "+888 1008 4169",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: false,
                  title: "- 188 TON",
                  titleStyle: .negative,
                  titleIsSecure: false,
                  description: "14 Jul, 07:10",
                  descriptionSecure: false
                ),
                additionText: nil,
                additionContent: nil,
                isSelectable: true,
                action: {}
              ),
              .init(
                .leftSide(
                  icon: Constants.mockImageData,
                  title: "Received",
                  description: "UQCZ...aO1R",
                  addition: nil,
                  additionStyle: .standart
                ),
                .rightSide(
                  isChevron: false,
                  title: "",
                  titleStyle: .positive,
                  titleIsSecure: true,
                  description: "",
                  descriptionSecure: true
                ),
                additionText: "Welcome to the TON DNS Club tondnsclub",
                additionContent: nil,
                isSelectable: true,
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
