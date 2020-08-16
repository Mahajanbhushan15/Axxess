import Foundation

/// It is use to handle success and failure of API response.
protocol APIResponseProtocol:AnyObject {
  func didReceivedResponse<T>(response:T?)
  func didReceivedFailure(error:String)
}
