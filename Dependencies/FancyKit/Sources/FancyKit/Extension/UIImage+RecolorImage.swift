//
//  UIImage+RecolorImage.swift
//
//
//  Created by Vitalii Sosin on 10.12.2023.
//

import SwiftUI
import FancyStyle

public extension UIImage {
  func recolorImage(with color: Color) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    color.uiColor.setFill()
    
    let context = UIGraphicsGetCurrentContext()
    context?.translateBy(x: 0, y: self.size.height)
    context?.scaleBy(x: 1.0, y: -1.0)
    context?.setBlendMode(.normal)
    
    let rect = CGRect(origin: .zero, size: self.size)
    context?.clip(to: rect, mask: self.cgImage!)
    context?.fill(rect)

    let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return coloredImage
  }
}
