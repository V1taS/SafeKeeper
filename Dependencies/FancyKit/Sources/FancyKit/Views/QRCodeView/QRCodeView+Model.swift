//
//  QRCodeView+Model.swift
//
//
//  Created by Vitalii Sosin on 13.12.2023.
//

import Foundation

// MARK: - Model

extension QRCodeView {
  public struct Model {
    public let iconData: Data?
    public let dataString: String
    public let getImageViewData: ((Data?) -> Void)?
    
    // MARK: - Initialization
    
    /// Инициализатор для создания модельки
    /// - Parameters:
    ///   - iconData: Иконка в центре QR
    ///   - dataString: Данные для генерации QR
    ///   - getImageViewData: Изображение всего вью
    public init(iconData: Data?,
                dataString: String,
                getImageViewData: ((Data?) -> Void)? = nil) {
      self.iconData = iconData
      self.dataString = dataString
      self.getImageViewData = getImageViewData
    }
  }
}
