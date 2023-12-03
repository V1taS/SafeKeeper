//
//  WidgetCryptocurrency.swift
//
//
//  Created by Vitalii Sosin on 03.12.2023.
//

import SwiftUI
import FancyStyle

public struct WidgetCryptocurrency: View {
  
  // MARK: - Private properties
  
  @Binding private var models: [WidgetCryptocurrency.Model]
  @State private var isPressed = false
  private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
  
  // MARK: - Initialization
  
  /// Инициализатор для создания виджета с криптовалютой
  /// - Parameters:
  ///   - text: Текст, который будет отображаться на кнопке
  init(models: Binding<[WidgetCryptocurrency.Model]>) {
    self._models = models
  }
  
  // MARK: - Body
  
  public var body: some View {
    ScrollView {
      LazyVStack(alignment: .center, spacing: .zero) {
        ForEach(Array(models.enumerated()), id: \.element.id) { index, model in
          createWidgetCryptocurrency(model: model)
          
          if models.count > 1 && models.count - 1 != index {
            Color.fancy.constant.slate.opacity(0.3)
              .frame(width: .infinity, height: 1)
          }
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: .s5))
    }
  }
}

// MARK: - Private

private extension WidgetCryptocurrency {
  func createWidgetCryptocurrency(model: WidgetCryptocurrency.Model) -> AnyView {
    AnyView(
      ZStack {
        Color.fancy.constant.navy
          .disabled(!model.isSelectable)
          .onLongPressGesture(
            minimumDuration: .infinity,
            maximumDistance: .infinity,
            pressing: { isPressing in
              if model.isSelectable {
                isPressed = isPressing
              }
            },
            perform: {
              model.action()
              impactFeedback.impactOccurred()
            }
          )
        
        HStack(spacing: .s4) {
          Image(uiImage: UIImage(data: model.imageData) ?? UIImage())
            .resizable()
            .frame(width: .s11, height: .s11)
            .clipShape(Circle())
          
          VStack(alignment: .leading, spacing: .s1) {
            Text(model.name)
              .font(.fancy.h3)
              .fontWeight(.semibold)
              .foregroundColor(.fancy.constant.ghost)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
            
            HStack {
              Text(model.currentPriceCryptoInCurrency)
                .font(.fancy.b1)
                .foregroundColor(.fancy.constant.slate)
                .lineLimit(Constants.lineLimit)
                .truncationMode(.tail)
              Spacer()
            }
          }
          
          Spacer()
          
          VStack(alignment: .trailing, spacing: .s1) {
            Text(model.totalCrypto)
              .font(.fancy.h3)
              .fontWeight(.semibold)
              .foregroundColor(.fancy.constant.ghost)
              .lineLimit(Constants.lineLimit)
              .truncationMode(.tail)
            
            HStack {
              Spacer()
              Text(model.totalCurrency)
                .font(.fancy.b1)
                .foregroundColor(.fancy.constant.slate)
                .lineLimit(Constants.lineLimit)
                .truncationMode(.tail)
            }
          }
        }
        .padding(.s4)
      }
        .animation(.easeInOut(duration: 0.2), value: isPressed)
    )
  }
}

// MARK: - Model

extension WidgetCryptocurrency {
  public struct Model: Identifiable {
    
    /// ID для модельки
    public let id = UUID()
    
    /// Название криптовалюты
    public let name: String
    
    /// Изображение криптовалюты
    public let imageData: Data
    
    /// Общая сумма крипто валюты
    public let totalCrypto: String
    
    /// Общая сумма в валюте
    public let totalCurrency: String
    
    /// Текущий прайс криптовалюты в валюте
    public let currentPriceCryptoInCurrency: String
    
    /// Можно ли нажать на ячейку
    public var isSelectable: Bool
    
    /// Замыкание, которое будет выполняться при нажатии на виджет
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки для виджета
    /// - Parameters:
    ///   - name: Название криптовалюты
    ///   - imageData: Изображение криптовалюты
    ///   - totalCrypto: Общая сумма крипто валюты
    ///   - totalCurrency: Общая сумма в валюте
    ///   - currentPriceCryptoInCurrency: Текущий прайс криптовалюты в валюте
    ///   - isSelectable: Можно ли нажать на ячейку
    ///   - action: Замыкание, которое будет выполняться при нажатии на виджет
    public init(name: String,
                imageData: Data,
                totalCrypto: String,
                totalCurrency: String,
                currentPriceCryptoInCurrency: String,
                isSelectable: Bool,
                action: @escaping () -> Void) {
      self.name = name
      self.imageData = imageData
      self.totalCrypto = totalCrypto
      self.totalCurrency = totalCurrency
      self.currentPriceCryptoInCurrency = currentPriceCryptoInCurrency
      self.isSelectable = isSelectable
      self.action = action
    }
  }
}

// MARK: - Constants

private enum Constants {
  static let lineLimit = 1
  static let mockImageData: Data = UIImage(systemName: "link.circle")?.pngData() ?? Data()
}

// MARK: - Preview

struct WidgetCryptocurrency_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      WidgetCryptocurrency(models: .constant([
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
          isSelectable: false,
          action: {}
        )
      ]))
    }
    .padding(.top, .s26)
    .padding(.horizontal)
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
