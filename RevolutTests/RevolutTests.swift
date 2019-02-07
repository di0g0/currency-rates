import XCTest

@testable import Revolut

class RevolutTests: XCTestCase {
    func testConversorCreation() {
        let sampleCurrency = Constants.CurrencyConversion.initialCurrencyViewModel
        let conversor = ConversionManager(baseCurrency: sampleCurrency)
        XCTAssertNotNil(conversor)
        XCTAssertEqual(conversor.baseCurrency.currencyCode, sampleCurrency.currencyCode)
    }
    
    func testCurrencyViewModel() {
        let currency = Currency.euro
        var viewModel = CurrencyViewModel(currency: currency, rate: 2)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.currencyCode, currency.code)
        XCTAssertEqual(viewModel.currencyName, currency.name)
        let mockValue = 5.5
        let mockResult = 11.0
        viewModel.value = mockValue
        XCTAssertEqual(viewModel.convertedValue, mockResult)
        XCTAssertEqual(viewModel.formatedValue, mockResult.currencyString)
    }
    
    func testCurrencyFormatting() {
        let doubleValue = 10.0
        XCTAssertEqual(doubleValue.currencyString.replacingOccurrences(of: ",", with: "."), "10.00")
    }
    
    func testPollingTimer() {
        let sampleCurrency = Constants.CurrencyConversion.initialCurrencyViewModel
        let conversor = ConversionManager(baseCurrency: sampleCurrency)
        conversor.startPollingRates()
        XCTAssertEqual(conversor.timer.isValid,true)
        XCTAssertEqual(conversor.timer.timeInterval, 1)
    }
    
    func testUpdateCurrencies() {
        let sampleCurrency = Constants.CurrencyConversion.initialCurrencyViewModel
        let conversor = ConversionManager(baseCurrency: sampleCurrency)
        let testExpectation = expectation(description: "Test updating currency list")
        conversor.onUpdateRates = { list in
            XCTAssertEqual(list.count, Currency.allCurrencies.count - 1)
            XCTAssertTrue((list as Any) is [CurrencyViewModel])
            testExpectation.fulfill()
        }
        conversor.updateCurrencies()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testStopUpdating() {
        let sampleCurrency = Constants.CurrencyConversion.initialCurrencyViewModel
        let conversor = ConversionManager(baseCurrency: sampleCurrency)
        conversor.startPollingRates()
        XCTAssertEqual(conversor.timer.isValid,true)
        conversor.cancelRequests()
        XCTAssertEqual(conversor.timer.isValid,false)
    }
    
    func testGetRateList() {
        let testExpectation = expectation(description: "Test getting rates")
        let service = CurrencyRatesService()
        service.getRates(baseCurrency: Currency.euro.code) { (error, rates) in
            dump(rates)
            XCTAssert(error == nil)
            XCTAssertNotNil(rates)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
}
