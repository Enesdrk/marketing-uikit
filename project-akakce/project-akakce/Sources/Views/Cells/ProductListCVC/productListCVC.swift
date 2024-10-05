//
//  productListCVC.swift
//  project-akakce
//
//  Created by Enes on 3.10.2024.
//

import UIKit

class productListCVC: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI(){
        productName.lineBreakMode = .byTruncatingTail
        productName.numberOfLines = 1
        productName.widthAnchor.constraint(lessThanOrEqualToConstant: 155).isActive = true
        
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 1.0) // Kare olacak şekilde oranını korur
        ])
    }

}
