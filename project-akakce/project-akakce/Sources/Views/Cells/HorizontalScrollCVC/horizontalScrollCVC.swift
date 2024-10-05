//
//  horizontalScrollCVC.swift
//  project-akakce
//
//  Created by Enes on 3.10.2024.
//

import UIKit

class horizontalScrollCVC: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI()
    {
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
    }

}
