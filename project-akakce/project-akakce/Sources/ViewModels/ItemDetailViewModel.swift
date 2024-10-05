//
//  ItemDetailViewModel.swift
//  project-akakce
//
//  Created by Enes on 3.10.2024.
//

import Alamofire

class ItemDetailViewModel {
    
    var productId: Int
    var product: Product?

    init(productId: Int) {
        self.productId = productId
    }
    
    var productTitle: String {
         return product?.title.capitalizedFirstLetter() ?? "No Title"
     }

     var productCategory: String {
         return product?.category.capitalizedFirstLetter() ?? "No Category"
     }

     var productDescription: String {
         return product?.description.capitalizedFirstLetter() ?? "No Description"
     }

     var productPrice: String {
         return "$\(product?.price ?? 0.0)"
     }

     var productImageURL: String {
         return product?.image ?? ""
     }

     var productCount: String {
         return "\(product?.rating.count ?? 0) reviews".capitalizedFirstLetter()
     }

     var productRating: Double {
         return product?.rating.rate ?? 0.0
     }

    func fetchProductDetail(with productId: Int, completion: @escaping () -> Void) {
        let url = "https://fakestoreapi.com/products/\(productId)"
        
        AF.request(url, method: .get).responseDecodable(of: Product.self) { response in
            switch response.result {
            case .success(let fetchedProduct):
                self.product = fetchedProduct
                completion() 
            case .failure(let error):
                print("Error fetching product details: \(error.localizedDescription)")
            }
        }
    }
}
