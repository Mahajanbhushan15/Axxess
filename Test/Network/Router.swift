import Foundation

/// This creates a URLComponents as per API.
public enum Router {
  case getData
}

extension Router: EndPointType {

  var scheme: String {
    switch self {
    case .getData:
      return "https"
    }
  }

  var host: String {
    switch self {
    case .getData:
      return "raw.githubusercontent.com"
    }
  }

  var path: String {
    switch self {
    case .getData:
      return "/AxxessTech/Mobile-Projects/master/challenge.json"
    }
  }

  var parameters: [URLQueryItem] {
    switch self {
    case .getData:
      return []
    }
  }

  var method: String {
    switch self {
    case .getData:
      return "GET"
    }
  }
}
