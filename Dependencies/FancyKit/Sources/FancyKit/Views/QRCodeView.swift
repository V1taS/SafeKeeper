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
  ///   - dataString: Данные для генерации QR
  ///   - icon: Иконка в центре QR
  ///   - imageViewData: Изображение всего вью
  public init(dataString: String,
              icon: Data?,
              imageViewData: ((Data?) -> Void)? = nil) {
    self.dataString = dataString
    self.qrCodeImage = QRCodeView.generateQRCode(
      from: dataString,
      icon: icon
    )
    imageViewData?(self.asUIImage().pngData())
  }
  
  // MARK: - Body
  
  public var body: some View {
    VStack(spacing: .zero) {
      if let qrCodeImage = qrCodeImage {
        Image(uiImage: qrCodeImage)
          .interpolation(.none)
          .resizable()
          .scaledToFit()
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

// MARK: - Private

private extension QRCodeView {
  static func generateQRCode(
    from string: String,
    backgroundColor: Color = .clear,
    foregroundColor: Color = .fancy.constant.navy,
    icon: Data?,
    iconSize: CGSize = CGSize(width: 100, height: 100)
  ) -> UIImage? {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data(string.utf8)
    filter.correctionLevel = "H"
    
    if let qrCodeCIImage = filter.outputImage {
      let transformedImage = qrCodeCIImage.transformed(
        by: CGAffineTransform(scaleX: 10, y: 10)
      )
      let colorParameters = [
        "inputColor0": CIColor(color: foregroundColor.uiColor),
        "inputColor1": CIColor(color: backgroundColor.uiColor)
      ]
      let colorFilter = CIFilter(name: "CIFalseColor", parameters: colorParameters)
      colorFilter?.setValue(transformedImage, forKey: "inputImage")
      
      if let coloredImage = colorFilter?.outputImage,
         let qrCodeCGImage = context.createCGImage(coloredImage, from: coloredImage.extent) {
        let qrCodeImage = UIImage(cgImage: qrCodeCGImage)
        return insertIcon(icon, in: qrCodeImage, iconSize: iconSize)
      }
    }
    return nil
  }
  
  static func insertIcon(
    _ iconData: Data?,
    in qrCodeImage: UIImage,
    iconSize: CGSize,
    iconBackgroundColor: Color = .fancy.constant.ghost
  ) -> UIImage? {
    var icon = UIImage()
    var iconBackgroundColor: UIColor = iconBackgroundColor.uiColor
    
    if let iconData, let image = UIImage(data: iconData) {
      icon = image
    } else {
      iconBackgroundColor = .clear
    }
    
    let size = qrCodeImage.size
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    
    qrCodeImage.draw(in: CGRect(origin: CGPoint.zero, size: size))
    let iconRect = CGRect(x: (size.width - iconSize.width) / 2.0,
                          y: (size.height - iconSize.height) / 2.0,
                          width: iconSize.width,
                          height: iconSize.height)
    
    let path = UIBezierPath(ovalIn: iconRect)
    iconBackgroundColor.setFill()
    path.fill()
    icon.draw(in: iconRect)
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resultImage
  }
}

// MARK: - Preview

struct QRCodeView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      QRCodeView(dataString: "tet",
                 icon: UIImage(systemName: "link.circle")?.pngData())
      Spacer()
    }
    .background(Color.fancy.constant.onyx)
    .ignoresSafeArea(.all)
  }
}
