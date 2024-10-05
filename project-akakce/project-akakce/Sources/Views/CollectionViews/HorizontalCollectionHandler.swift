//
//  HorizontalCollectionViewDelegate.swift
//  project-akakce
//
//  Created by Enes on 4.10.2024.
//

import UIKit

protocol HorizontalCollectionHandlerDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class HorizontalCollectionHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let viewModel: ProductListViewModel
    weak var dotsStackView: UIStackView?
    var dots: [UIView] = []
    
    weak var delegate: HorizontalCollectionHandlerDelegate?

    init(viewModel: ProductListViewModel, dotsStackView: UIStackView?) {
        self.viewModel = viewModel
        self.dotsStackView = dotsStackView
        super.init()
        setupDotsIndicator()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalScrollCell", for: indexPath) as! horizontalScrollCVC
        let product = viewModel.product(at: indexPath.row)

        cell.productName.text = product.title
        cell.productPrice.text = "$\(product.price)"
        cell.productImage.image = nil
        if let url = URL(string: product.image) {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }
        }
        cell.productImage.contentMode = .scaleAspectFit
        configureStars(for: cell, with: product.rating.rate)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.product(at: indexPath.row)
        delegate?.didSelectProduct(selectedProduct)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let collectionView = scrollView as? UICollectionView,
           let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            updateDotIndicator(selectedIndex: visibleIndexPath.row)
        }
    }

    func configureStars(for cell: horizontalScrollCVC, with rating: Double) {
        let fullStars = Int(rating)
        let halfStar = rating.truncatingRemainder(dividingBy: 1) >= 0.5

        let starImages = [cell.imgStar1, cell.imgStar2, cell.imgStar3, cell.imgStar4, cell.imgStar5]

        for (index, star) in starImages.enumerated() {
            if index < fullStars {
                star?.image = UIImage(named: "vector-default")
            } else if index == fullStars && halfStar {
                star?.image = UIImage(named: "vector-half")
            } else {
                star?.image = UIImage(named: "vector-empty")
            }
        }
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
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

    func setupDotsIndicator() {
        guard let dotsStackView = dotsStackView else { return }
        
        dotsStackView.axis = .horizontal
        dotsStackView.distribution = .fillEqually
        dotsStackView.alignment = .center
        dotsStackView.spacing = 10

        for _ in 0..<5 {
            let dot = UIView()
            dot.layer.cornerRadius = 10
            dot.backgroundColor = .lightGray
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: 4).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 4).isActive = true
            dots.append(dot)
            dotsStackView.addArrangedSubview(dot)
        }
        updateDotIndicator(selectedIndex: 0)
    }

    private func updateDotIndicator(selectedIndex: Int) {
        for (index, dot) in dots.enumerated() {
            dot.backgroundColor = index == selectedIndex ? .blue : .lightGray
        }
    }
}
