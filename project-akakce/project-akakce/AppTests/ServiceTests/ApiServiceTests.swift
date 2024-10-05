//
//  ApiServiceTests.swift
//  ApiServiceTests
//
//  Created by Enes on 5.10.2024.
//

import XCTest
import Alamofire

@testable import project_akakce

class ApiServiceTests: XCTestCase {

    var apiService: ApiService!

    override func setUp() {
        super.setUp()
        apiService = ApiService()
    }

    override func tearDown() {
        apiService = nil
        super.tearDown()
    }

    func testFetchProducts() {
        let expectation = self.expectation(description: "Fetch Products")

        apiService.fetchProducts { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 5, "Expected 5 products to be fetched.")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching products: \(error)")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

class ApiService {
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = "https://fakestoreapi.com/products"

        AF.request(url, method: .get).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                let limitedProducts = Array(products.prefix(5))
                completion(.success(limitedProducts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
