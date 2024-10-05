//
//  ProductListViewModelTests.swift
//  ProductListViewModelTests
//
//  Created by Enes on 5.10.2024.
//

import XCTest
@testable import project_akakce

class ProductListViewModelTests: XCTestCase {

    var viewModel: ProductListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testNumberOfProducts() {
        let expectation = self.expectation(description: "Product Fetching")
        
        viewModel.fetchProducts {
            XCTAssertEqual(self.viewModel.numberOfProducts, 5, "Fetched product count should be 5.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testProductFetchingSuccess() {
        let expectation = self.expectation(description: "Product Fetching")
        
        viewModel.fetchProducts {
            XCTAssertNotNil(self.viewModel.product(at: 0), "First product should not be nil.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testProductFetchingFailure() {
        print("Hatalı product fetching testi")
    }
}
