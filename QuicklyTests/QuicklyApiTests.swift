//
//  Quickly
//

import XCTest
import Quickly

class QuicklyApiTests : XCTestCase {

    func testGetApi() {
        let expectation = self.expectation(description: "")

        let provider = QApiProvider(
            baseUrl: URL(string: "https://habrahabr.ru")!,
            sessionConfiguration: URLSessionConfiguration.default,
            sessionQueue: OperationQueue()
        )

        let request = QApiRequest(method: "GET")
        request.logging = .always

        let response = QApiResponse()

        _ = provider.send(request: request, response: response) { (request: QApiRequest, response: QApiResponse) in
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 100)
    }
    
}
