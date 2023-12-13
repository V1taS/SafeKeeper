//
//  QRCodeView.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle
import CoreImage.CIFilterBuiltins

public struct QRCodeView: View {
  
  // MARK: - Private properties
  
  private let qrCodeImage: UIImage?
  private let dataString: String
  
  // MARK: - Initialization
  
  /// Инициализатор для создания QR
  /// - Parameters:
  ///   - model: Модель данных
  public init(_ model: QRCodeView.Model) {
    self.dataString = model.dataString
    self.qrCodeImage = QRCodeView.generateQRCode(
      from: model.dataString,
      icon: model.iconData
    )
    model.getImageViewData?(self.asUIImage().pngData())
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(spacing: .zero) {
      if let qrCodeImage = qrCodeImage {
        Image(uiImage: qrCodeImage)
          .interpolation(.none)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(.horizontal, .s5)
          .padding(.top, .s5)
          .padding(.bottom, .s1)
      }
      
      Text(dataString)
        .font(.fancy.h2)
        .foregroundColor(.fancy.constant.navy)
        .lineLimit(.max)
        .truncationMode(.tail)
        .allowsHitTesting(false)
        .padding(.horizontal, .s5)
        .multilineTextAlignment(.center)
        .padding(.bottom, .s5)
    }
    .background(Color.fancy.constant.ghost)
    .clipShape(RoundedRectangle(cornerRadius: .s5))
  }
}

// MARK: - Preview

struct QRCodeView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      QRCodeView(
        .init(
          iconData: UIImage(systemName: "link.circle")?.pngData(),
          dataString: "tet"
        )
      )
      Spacer()
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
