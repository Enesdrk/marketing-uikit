//
//  VerticalCollectionHandlerTests.swift
//  VerticalCollectionHandlerTests
//
//  Created by Enes on 5.10.2024.
//

import XCTest
@testable import project_akakce

class VerticalCollectionHandlerTests: XCTestCase {

    var viewModel: ProductListViewModel!
    var collectionHandler: VerticalCollectionHandler!
    var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
        collectionHandler = VerticalCollectionHandler(viewModel: viewModel)

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
        viewModel.fetchVerticalProducts {
            let itemCount = self.collectionHandler.collectionView(self.collectionView, numberOfItemsInSection: 0)
            XCTAssertGreaterThan(itemCount, 0, "Dikey CollectionView'de en az 1 ürün olmalı.")
        }
    }
}
