import Foundation
import Alamofire

/// This is class handles all types of requests and make a network call,
/// decode the response in requested object and send back to viewModel.
final class APIService: NetworkRouter {

  func request<T>(
    router: Router,
    completion: @escaping (DataResponse<[T], AFError>) -> ()) where T : Decodable, T : Encodable {
    
    var components = URLComponents()
    components.scheme = router.scheme
    components.host = router.host
    components.path = router.path
    components.queryItems = router.parameters
    guard let url = components.url else {
      return
    }
    let urlRequest = URLRequest(url: url)

    // Network request using Alamofire
    AF.request(urlRequest).responseDecodable(of: [T].self) { response in
      completion(response)
    }
  }

  func cancel() {
    // Not implemented
  }
}
