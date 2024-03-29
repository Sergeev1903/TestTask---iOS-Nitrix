//
//  RequestError.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

enum RequestError: Error {
  case decode
  case encode
  case invalidURL
  case noResponse
  case unauthorized
  case unexpectedStatusCode(code: Int)
  case unknown
  
  var message: String {
    var result = ""
    switch self {
    case .decode:
      result = "Decode error"
    case .encode:
      result = "Encode error"
    case .invalidURL:
      result = "URL error"
    case .noResponse:
      result = "Response error"
    case .unauthorized:
      result = "Session expired"
    case .unexpectedStatusCode(let code):
      result = "Unexpected error: \(code)"
    case .unknown:
      result = "Unknown error"
    }
    return result
  }
}
