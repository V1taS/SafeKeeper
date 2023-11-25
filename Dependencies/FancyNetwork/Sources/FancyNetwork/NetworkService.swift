//
//  NetworkService.swift
//
//
//  Created by Vitalii Sosin on 30.04.2022.
//

import Foundation

/// Сервис по работе с сетью
public protocol NetworkService {
  
  /// Сделать запрос в сеть
  ///  - Parameters:
  ///   - urlString: Адрес запроса
  ///   - queryItems: Query параметры
  ///   - httpMethod: Метод запроса
  ///   - headers: Хедеры
  ///   - Reuterns: Результат выполнения
  func performRequestWith(urlString: String,
                          queryItems: [URLQueryItem],
                          httpMethod: NetworkMethod,
                          headers: [HeadersType],
                          completion: ((Result<Data?, NetworkError>) -> Void)?)
  
  /// Делает маппинг из `JSON` в структуру данных типа `Generic`
  /// - parameters:
  ///  - result: модель данных с сервера
  ///  - to: В какой тип данных маппим
  /// - returns: Результат маппинга в структуру `Generic`
  func map<ResponseType: Codable>(_ result: Data?,
                                  to _: ResponseType.Type) -> ResponseType?
}

/// Исполнитель запроса сеанса URL
public final class NetworkServiceImpl {
  
  // MARK: - Public variable
  
  /// Время ожидания для запросов URL
  public var timeoutIntervalForRequest: Double? {
    didSet {
      guard let timeoutIntervalForRequest else {
        return
      }
      session.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
    }
  }
  
  /// Время ожидания для ответов URL
  public var timeoutIntervalForResource: Double? {
    didSet {
      guard let timeoutIntervalForResource else {
        return
      }
      session.configuration.timeoutIntervalForResource = timeoutIntervalForResource
    }
  }
  
  // MARK: - Private variable
  
  private let session: URLSession = URLSession.shared
  private let networkReachability: NetworkReachability? = DefaultNetworkReachability()
  
  // MARK: - Initialization
  
  public init() {}
}

// MARK: - NetworkService

extension NetworkServiceImpl: NetworkService {
  public func performRequestWith(urlString: String,
                                 queryItems: [URLQueryItem],
                                 httpMethod: NetworkMethod,
                                 headers: [HeadersType],
                                 completion: ((Result<Data?, NetworkError>) -> Void)?) {
    DispatchQueue.global().async { [weak self] in
      guard self?.networkReachability?.isReachable ?? false else {
        completion?(.failure(.noInternetConnection))
        return
      }
      
      guard var components = URLComponents(string: urlString) else {
        completion?(.failure(.invalidURLRequest))
        return
      }
      components.queryItems = queryItems
      
      guard let url = components.url else {
        completion?(.failure(.invalidURLRequest))
        return
      }
      
      var requestURL = URLRequest(url: url)
      requestURL.httpMethod = httpMethod.rawValue
      
      switch httpMethod {
      case let .post(data):
        requestURL.httpBody = data
      case let .put(data):
        requestURL.httpBody = data
      case let .patch(data):
        requestURL.httpBody = data
      default: break
      }
      
      headers.forEach { headersType in
        headersType.headers.forEach {
          requestURL.setValue($0, forHTTPHeaderField: $1)
        }
      }
      
#if DEBUG
      print("\n\nRequest:\n\(requestURL.curlString)")
#endif
      
      let task = self?.session.dataTask(with: requestURL) { data, response, error in
        if let error {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? .zero
          completion?(.failure(.unacceptedHTTPStatus(code: statusCode,
                                                     localizedDescription: error.localizedDescription)))
        }
        completion?(.success(data))
      }
      task?.resume()
    }
  }
  
  public func map<ResponseType: Codable>(_ result: Data?, to _: ResponseType.Type) -> ResponseType? {
    guard let data = result else {
      return nil
    }
    
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(ResponseType.self, from: data)
      return result
    } catch {
      return nil
    }
  }
}

// MARK: - Appearance

private extension NetworkServiceImpl {
  struct Appearance {
    let timeOutInterval: Double = 90
  }
}
