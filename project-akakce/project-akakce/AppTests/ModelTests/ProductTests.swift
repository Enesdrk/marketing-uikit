//
//  ProductTests.swift
//  ProductTests
//
//  Created by Enes on 5.10.2024.
//

import XCTest
@testable import project_akakce

class ProductTests: XCTestCase {

    func testProductInitialization() {
        let product = Product(id: 1, title: "Test Product", price: 10.0, description: "Test description", category: "Electronic", image: "imageURL", rating: Rating(rate: 4.5, count: 100))

        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.title, "Test Product")
        XCTAssertEqual(product.price, 10.0)
        XCTAssertEqual(product.rating.rate, 4.5)
    }
}
