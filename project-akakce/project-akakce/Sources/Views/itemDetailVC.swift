//
//  itemDetailVC.swift
//  project-akakce
//
//  Created by Enes on 3.10.2024.
//

import UIKit

class itemDetailVC: UIViewController {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    @IBOutlet weak var productCount: UILabel!
    
    @IBOutlet weak var imgStr1: UIImageView!
    @IBOutlet weak var imgStr2: UIImageView!
    @IBOutlet weak var imgStr3: UIImageView!
    @IBOutlet weak var imgStr4: UIImageView!
    @IBOutlet weak var imgStr5: UIImageView!
    

    var viewModel: ItemDetailViewModel?
      var productId: Int?

      override func viewDidLoad() {
          super.viewDidLoad()

          // `productId` mevcutsa, `viewModel`'i başlatıyoruz
          if let productId = productId {
              viewModel = ItemDetailViewModel(productId: productId)
              
              // `viewModel` üzerinden ürünü fetch ediyoruz
              viewModel?.fetchProductDetail(with: productId) {
                  DispatchQueue.main.async {
                      self.updateUI()
                  }
              }
          }
      }

      // UI'yi güncelleyen fonksiyon
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        productTitle.text = viewModel.product?.title
        productCategory.text = viewModel.product?.category
        productDescription.text = viewModel.product?.description
        productPrice.text = String(format: "$%.2f", viewModel.product?.price ?? 0.0)
        productCount.text = "\(viewModel.product?.rating.count ?? 0)"
        
        if let url = URL(string: viewModel.product?.image ?? "") {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            }
        }
        
        configureStars(with: viewModel.product?.rating.rate ?? 0.0)
    }

      // Resmi indirme fonksiyonu
      private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
          URLSession.shared.dataTask(with: url) { data, response, error in
              guard let data = data, let image = UIImage(data: data), error == nil else {
                  completion(nil)
                  return
              }
              completion(image)
          }.resume()
      }

      // Yıldızları konfigüre eden fonksiyon
      private func configureStars(with rating: Double) {
          let fullStars = Int(rating)
          let hasHalfStar = rating.truncatingRemainder(dividingBy: 1) >= 0.5

          let starImages = [imgStr1, imgStr2, imgStr3, imgStr4, imgStr5]
          
          for (index, star) in starImages.enumerated() {
              if index < fullStars {
                  star?.image = UIImage(named: "vector-default")
              } else if index == fullStars && hasHalfStar {
                  star?.image = UIImage(named: "vector-half")
              } else {
                  star?.image = UIImage(named: "vector-empty")
              }
          }
      }
  }
