//
//  HorizontalCollectionHandlerTests.swift
//  HorizontalCollectionHandlerTests
//
//  Created by Enes on 5.10.2024.
//
import XCTest
@testable import project_akakce

class HorizontalCollectionHandlerTests: XCTestCase {

    var viewModel: ProductListViewModel!
    var collectionHandler: HorizontalCollectionHandler!
    var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
        collectionHandler = HorizontalCollectionHandler(viewModel: viewModel, dotsStackView: nil)

        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = collectionHandler
        collectionView.delegate = collectionHandler
    }

    override func tearDown() {
        collectionHandler = nil
        viewModel = nil
        collectionView = nil
        super.tearDown()
    }

    func testNumberOfItemsInSection() {
        viewModel.fetchProducts {
            let itemCount = self.collectionHandler.collectionView(self.collectionView, numberOfItemsInSection: 0)
            XCTAssertEqual(itemCount, 5, "Yatay CollectionView'de 5 ürün olmalı.")
        }
    }
}
