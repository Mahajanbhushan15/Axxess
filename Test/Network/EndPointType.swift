import Foundation

/// Protocol to create URLComponents.
protocol EndPointType {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var parameters: [URLQueryItem] { get }
  var method: String { get }
}
