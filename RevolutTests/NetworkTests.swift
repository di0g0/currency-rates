import XCTest

@testable import Revolut
import Mockingjay

class NetworkTests: XCTestCase {    
    func testServerError() {
        let testExpectation = expectation(description: "Test server error")
        stub(everything, http(500))
        let service = CurrencyRatesService()
        service.getRates(baseCurrency: "EUR") { (error, rates) in
            dump(error)
            XCTAssertNotNil(error)
            XCTAssertEqual(APIClientError.serverError, error as? APIClientError)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testJsonParsingError() {
        let testExpectation = expectation(description: "Test json error")
        let body = ["base":"EUR", "rates":nil]
        stub(uri("/latest"), json(body))
        let service = CurrencyRatesService()
        service.getRates(baseCurrency: "EUR") { (error, rates) in
            dump(error)
            XCTAssertNotNil(error)
            XCTAssertEqual(APIClientError.jsonParsingError, error as? APIClientError)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testSuccess() {
        let testExpectation = expectation(description: "Test loading json")
        let url = Bundle(for: type(of: self)).url(forResource: "latest", withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        stub(uri("/latest"), jsonData(data))
        let service = CurrencyRatesService()
        service.getRates(baseCurrency: "EUR") { (error, rates) in
            dump(rates)
            XCTAssertNotNil(rates)
            XCTAssertTrue((rates as Any) is [String: Double])
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

