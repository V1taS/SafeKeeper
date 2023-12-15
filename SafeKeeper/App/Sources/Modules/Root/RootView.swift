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
  @State private var inputContentSize = "12"
  
  @State private var currency = "112"
  
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
              action: {}
            )
            
            RoundButtonView(
              style: .custom(imageData: nil, text: "Max"),
              action: {}
            )
          }
          .padding(.bottom)
          
          QRCodeView(
            iconData: UIImage(systemName: "link.circle")?.pngData(),
            dataString: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf"
          )
          .padding(.bottom)
          
          TitleAndSubtitleView(
            .title(
              text: "$ 153,04",
              lineLimit: 1,
              isSelectable: true,
              isSecure: false,
              action: {}
            ),
            .description(
              text: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
              lineLimit: 1,
              isSelectable: true,
              isSecure: false,
              action: {}),
            alignment: .center,
            style: .large
          )
          .padding(.bottom)
          
          TitleAndSubtitleView(
            .title(
              text: "",
              lineLimit: 1,
              isSelectable: true,
              isSecure: true,
              action: {}
            ),
            .description(
              text: "UQApvTCMascwAmF_LVtNJeEIUzZUOGR_h66t8FilkNf",
              lineLimit: 1,
              isSelectable: true,
              isSecure: false,
              action: {}),
            alignment: .center,
            style: .large
          )
          .padding(.bottom)
          
          Group {
            InputView(
              text: $inputViewOne, 
              bottomHelper: .constant("Helper text"),
              isError: .constant(false),
              isEnabled: .constant(true),
              isTextFieldFocused: .constant(nil),
              isColorFocusBorder: .constant(true),
              placeholder: "Input view one",
              style: .none,
              keyboardType: .default,
              maxLength: 10,
              textFont: nil,
              backgroundColor: nil
            )
            
            InputView(
              text: $inputViewTwo,
              bottomHelper: .constant(nil),
              isError: .constant(false),
              isEnabled: .constant(true),
              isTextFieldFocused: .constant(nil),
              isColorFocusBorder: .constant(true),
              placeholder: "Input view two",
              style: .leftHelper(text: "22:"),
              keyboardType: .default,
              maxLength: 20,
              textFont: nil,
              backgroundColor: nil
            )
            
            InputView(
              text: $inputViewThree, 
              bottomHelper: .constant("Helper text"),
              isError: .constant(true),
              isEnabled: .constant(true),
              isTextFieldFocused: .constant(nil),
              isColorFocusBorder: .constant(true),
              placeholder: "Input view three",
              style: .topHelper(text: "Comments"),
              keyboardType: .default,
              maxLength: 10,
              textFont: nil,
              backgroundColor: nil
            )
          }
          
          Group {
            HStack {
              Spacer()
              CircleButtonView(
                text: "Send",
                type: .custom(systemNameImage: "arrow.up.arrow.down"),
                size: .large,
                action: {}
              )
              CircleButtonView(
                text: "Receive",
                type: .receive,
                size: .small,
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
                  MainButtonView(
                    text: .constant("Any view here"),
                    isEnabled: .constant(true),
                    style: .primary,
                    action: {}
                  )
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
                text: .constant("Кнопка primary"),
                isEnabled: .constant(true),
                style: .primary,
                action: {}
              )
              
              MainButtonView(
                text: .constant("Кнопка secondary"),
                isEnabled: .constant(true),
                style: .secondary,
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
