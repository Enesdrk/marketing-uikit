//
//  VerticalCollectionHandlerDelegate.swift
//  project-akakce
//
//  Created by Enes on 4.10.2024.
//

import UIKit

protocol VerticalCollectionHandlerDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class VerticalCollectionHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let viewModel: ProductListViewModel
    weak var delegate: VerticalCollectionHandlerDelegate?

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfVerticalProducts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productListCVC", for: indexPath) as! productListCVC
        let product = viewModel.verticalProduct(at: indexPath.row)

        cell.productName.text = product.title
        cell.productPrice.text = "$\(product.price)"
        cell.productCount.text = "\(product.rating.count) available"
        cell.productImage.image = nil

        if let url = URL(string: product.image) {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }
        }

        cell.productImage.contentMode = .scaleAspectFit

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.verticalProduct(at: indexPath.row)
        delegate?.didSelectProduct(selectedProduct)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let screenWidth = collectionView.frame.width
         let desiredNumberOfColumns: CGFloat = 2
         let padding: CGFloat = 16
         let interItemSpacing: CGFloat = 8
         
         let totalPadding = padding + (interItemSpacing * (desiredNumberOfColumns - 1))
         let availableWidth = screenWidth - totalPadding
         let itemWidth = availableWidth / desiredNumberOfColumns
         
         return CGSize(width: itemWidth, height: itemWidth)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 8
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 16 
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
     }

    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Image download failed: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Image download failed: data is nil or image could not be created")
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
