//
//  ViewControllerTests.swift
//  RevolutTests
//
//  Created by Diogo Costa on 07/02/19.
//  Copyright © 2019 Diogo Costa. All rights reserved.
//

import XCTest
@testable import Revolut

class ViewControllerTests: XCTestCase {
    var viewController: CurrencyListViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        viewController = navigationController?.topViewController as? CurrencyListViewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.view)
    }
    
    func testTableViewRowHeight() {
        let expectedHeight:CGFloat = 60
        XCTAssertEqual(viewController?.tableView.rowHeight, expectedHeight)
    }
    
    func testNumberOfRowsOnFirstSection() {
        let baseCurrencyRowCount = 1
        XCTAssertEqual(viewController?.tableView.numberOfRows(inSection: TableSection.selectedCurrency.rawValue), baseCurrencyRowCount)
    }
    
    func testCreateCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = viewController?.tableView.cellForRow(at: indexPath) as? CurrencyRateCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.reuseIdentifier, CurrencyRateCell.identifier)
        let viewModel = Constants.CurrencyConversion.initialCurrencyViewModel
        cell?.fill(with: viewModel)
        XCTAssertEqual(cell?.codeLabel.text, viewModel.currencyCode)
        XCTAssertEqual(cell?.currencyNameLabel.text, viewModel.currencyName)
        XCTAssertEqual(cell?.rateTextField.text, viewModel.formatedValue)
    }
}
