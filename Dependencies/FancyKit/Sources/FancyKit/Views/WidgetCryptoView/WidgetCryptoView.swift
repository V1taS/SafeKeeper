//
//  WidgetCryptoView.swift
//
//
//  Created by Vitalii Sosin on 03.12.2023.
//

import SwiftUI
import FancyStyle

public struct WidgetCryptoView: View {
  
  // MARK: - Private properties
  
  @Binding private var models: [WidgetCryptoView.Model]
  
  // MARK: - Initialization
  
  /// Инициализатор для создания виджета с криптовалютой
  /// - Parameters:
  ///   - models: Модели данных
  public init(models: Binding<[WidgetCryptoView.Model]>) {
    self._models = models
  }
  
  // MARK: - Body
  
  public var body: some View {
    LazyVStack(alignment: .center, spacing: .zero) {
      ForEach(Array(models.enumerated()), id: \.element.id) { index, model in
        createWidgetCrypto(model: model)
        
        if models.count > 1 && models.count - 1 != index {
          Color.fancy.constant.slate.opacity(0.3)
            .frame(width: .infinity, height: 1)
        }
      }
    }
    .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Private

private extension WidgetCryptoView {
  func createWidgetCrypto(model: WidgetCryptoView.Model) -> AnyView {
    AnyView(
      ZStack {
        TapGestureView(
          .init(
            content: AnyView(
              Color.fancy.constant.navy
            ),
            style: .flash,
            isEnabled: .constant(model.isSelectable),
            touchesEnded: {
              model.action()
            }
          )
        )
        
        VStack(spacing: .zero) {
          HStack(spacing: .s4) {
            // MARK: - Левая сторона виджета
            if case let .leftSide(icon, title, description,
                                  addition, additionStyle) = model.leftSide {
              if let icon {
                Image(uiImage: UIImage(data: icon) ?? UIImage())
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: .s11, height: .s11)
                  .clipShape(Circle())
                  .allowsHitTesting(false)
              }
              
              VStack(alignment: .leading, spacing: .s1) {
                Text(title)
                  .font(.fancy.h3)
                  .foregroundColor(.fancy.constant.ghost)
                  .lineLimit(Constants.lineLimit)
                  .truncationMode(.tail)
                  .allowsHitTesting(false)
                
                HStack {
                  Text(description)
                    .font(.fancy.b1)
                    .foregroundColor(.fancy.constant.slate)
                    .lineLimit(Constants.lineLimit)
                    .truncationMode(.middle)
                    .allowsHitTesting(false)
                  
                  if let addition {
                    Text(addition)
                      .font(.fancy.b1)
                      .foregroundColor(additionStyle.color)
                      .lineLimit(Constants.lineLimit)
                      .truncationMode(.tail)
                      .allowsHitTesting(false)
                  }
                }
              }
            }
            
            Spacer()
            
            // MARK: -  Правая сторона
            if case let .rightSide(isChevron, title, titleStyle, titleIsSecure,
                                   description, descriptionSecure) = model.rightSide {
              if isChevron {
                VStack(alignment: .trailing) {
                  Spacer()
                  Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .s4, height: .s4)
                    .foregroundColor(.fancy.constant.slate)
                    .allowsHitTesting(false)
                  Spacer()
                }
              } else {
                VStack(alignment: .trailing, spacing: .s1) {
                  Text(titleIsSecure ? Constants.secureText : title)
                    .font(.fancy.h3)
                    .foregroundColor(titleStyle.color)
                    .lineLimit(Constants.lineLimit)
                    .truncationMode(.tail)
                    .allowsHitTesting(false)
                  
                  HStack {
                    Spacer()
                    Text(descriptionSecure ? Constants.secureText : description)
                      .font(.fancy.b1)
                      .foregroundColor(.fancy.constant.slate)
                      .lineLimit(Constants.lineLimit)
                      .truncationMode(.tail)
                      .allowsHitTesting(false)
                  }
                }
              }
            }
          }
          
          if let additionContent = model.additionContent {
            additionContent
              .padding(.top, .s4)
          }
          
          if let additionText = model.additionText {
            Text(additionText)
              .font(.fancy.b2)
              .foregroundColor(.fancy.constant.ghost)
              .multilineTextAlignment(.center)
              .roundedEdge(backgroundColor: .fancy.constant.ghost.opacity(0.07))
              .padding(.top, .s4)
              .allowsHitTesting(false)
          }
          
        }
        .padding(.s4)
      }
    )
  }
}

// MARK: - Constants

private enum Constants {
  static let secureText = "* * *"
  static let lineLimit = 1
  static let mockImageData: Data = UIImage(systemName: "link.circle")?.pngData() ?? Data()
}

// MARK: - Preview

struct WidgetCryptoView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      WidgetCryptoView(
        models: .constant(
          [
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
              additionText: "Welcome to the TON DNS Club tondnsclub Welcome to the TON DNS Club",
              additionContent: nil,
              isSelectable: true,
              action: {}
            )
          ]
        )
      )
      Spacer()
    }
    .padding(.top, .s26)
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
