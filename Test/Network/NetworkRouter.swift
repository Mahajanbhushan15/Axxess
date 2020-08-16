import Foundation
import Alamofire

/// Protocol to make network request.
protocol NetworkRouter: class {

  func request<T: Codable>(
    router: Router,
    completion: @escaping (DataResponse<[T], AFError>) -> ()
  )

  func cancel()
}
