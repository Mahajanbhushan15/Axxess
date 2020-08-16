import Foundation
import Alamofire
import Reachability

/// Use this class to make a API request.
/// Buissness logic implemented here.
final class TestViewModel {

  weak var responseDelegate: APIResponseProtocol?

  var apiService: APIService?

  init(apiService: APIService = APIService()) {
    self.apiService = apiService
  }

  /// API request to fetch articles.
  func fetchData() {
    if let networkManager = NetworkReachabilityManager(),
      networkManager.isReachable {

      // Fetch data from server.
      apiService?.request(
        router: Router.getData,
        completion: { (response: DataResponse<[Test], AFError>) in

          switch response.result {
          case .success(let data):

            // Store data in local database.
            DBManager.sharedInstance.addData(objects: data)

            // Send response back to view for UI update.
            self.responseDelegate?.didReceivedResponse(response: data)

          case .failure(let error):

            // Send error back to view.
            self.responseDelegate?.didReceivedFailure(error: error.localizedDescription)
          }
      })
    } else {
      // Retrieve data from local database.

      DBManager.sharedInstance.retrieveData(ofType: Test.self) { response in
        self.responseDelegate?.didReceivedResponse(response: response)
      }
    }
  }
}
