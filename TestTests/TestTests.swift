import XCTest
@testable import Test

class TestTests: XCTestCase, APIResponseProtocol {

  var promise: XCTestExpectation?
  var viewModel: TestViewModel?

  override func setUp() {
    super.setUp()
    viewModel = TestViewModel()
    viewModel?.responseDelegate = self
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    viewModel = nil
  }

  func testFetchDataWebService() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    promise = expectation(description: "Asynchronous web Service.")
    viewModel?.fetchData()
    wait(for: [promise!], timeout: 10)
  }

  func didReceivedResponse<T>(response: T?) {
    XCTAssertNotNil(response)
    promise?.fulfill()
  }

  func didReceivedFailure(error: String) {
    XCTFail("Error description: \(error)")
  }
}
