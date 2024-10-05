//
//  ItemDetailViewModelTests.swift
//  ItemDetailViewModelTests
//
//  Created by Enes on 5.10.2024.
//

import XCTest
@testable import project_akakce

class ItemDetailViewModelTests: XCTestCase {

    var viewModel: ItemDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ItemDetailViewModel(productId: 1)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testProductDetailFetchingSuccess() {
        let expectation = self.expectation(description: "Ürün Detaylarının Getirilmesi")

        viewModel.fetchProductDetail(with: 1) {
            XCTAssertEqual(self.viewModel.product?.id, 1, "Doğru ürün detayı getirilmelidir.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testProductDetailFetchingFailure() {
        print("Hatalı ürün detayı getirilmelidir.")
    }
}
