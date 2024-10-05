//
//  ProductListViewModel.swift
//  project-akakce
//
//  Created by Enes on 2.10.2024.
//
import UIKit
import Alamofire

class ProductListViewModel {

    private var products: [Product] = []
    private var verticalProducts: [Product] = []
    var numberOfProducts: Int {
        return products.count
    }
    
    var numberOfVerticalProducts: Int {
        return verticalProducts.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }
    
    func verticalProduct(at index: Int) -> Product {
        return verticalProducts[index]
    }

    func fetchProducts(completion: @escaping () -> Void) {
        let url = "https://fakestoreapi.com/products"
        
        AF.request(url, method: .get).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                self.products = Array(products.prefix(5))
                completion()
                
            case .failure(let error):
                print("Error fetching products: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func fetchVerticalProducts(completion: @escaping () -> Void) {
        let url = "https://fakestoreapi.com/products"

        AF.request(url, method: .get).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                self.verticalProducts = products
                completion()
            case .failure(let error):
                print("Error fetching vertical products: \(error.localizedDescription)")
                completion()
            }
        }
    }
}
