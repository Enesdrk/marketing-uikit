//
//  ProductListVC.swift
//  project-akakce
//
//  Created by Enes on 2.10.2024.
//
import UIKit

class ProductListVC: UIViewController, HorizontalCollectionHandlerDelegate, VerticalCollectionHandlerDelegate {

    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var dotsStackView: UIStackView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    private let viewModel = ProductListViewModel()
    private var horizontalHandler: HorizontalCollectionHandler?
    private var verticalHandler: VerticalCollectionHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        horizontalHandler = HorizontalCollectionHandler(viewModel: viewModel, dotsStackView: dotsStackView)
        horizontalHandler?.delegate = self

        setupHorizontalCollectionView()

        verticalHandler = VerticalCollectionHandler(viewModel: viewModel)
        verticalHandler?.delegate = self

        setupVerticalCollectionView()
        bindViewModel()
      }

    private func setupHorizontalCollectionView() {
        let nib = UINib(nibName: "horizontalScrollCVC", bundle: nil)
        horizontalCollectionView.register(nib, forCellWithReuseIdentifier: "horizontalScrollCell")
        horizontalCollectionView.dataSource = horizontalHandler
        horizontalCollectionView.delegate = horizontalHandler

        if let layout = horizontalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
        }
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.isPagingEnabled = true
    }

    private func setupVerticalCollectionView() {
        let nib = UINib(nibName: "productListCVC", bundle: nil)
        verticalCollectionView.register(nib, forCellWithReuseIdentifier: "productListCVC")
        verticalCollectionView.dataSource = verticalHandler
        verticalCollectionView.delegate = verticalHandler

        if let layout = verticalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        }
        verticalCollectionView.showsVerticalScrollIndicator = true
    }

    private func bindViewModel() {
        viewModel.fetchProducts {
            self.horizontalCollectionView.reloadData()
        }
        
        viewModel.fetchVerticalProducts {
            self.verticalCollectionView.reloadData()
        }
    }

      func didSelectProduct(_ product: Product) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          if let detailVC = storyboard.instantiateViewController(withIdentifier: "itemDetailVC") as? itemDetailVC {
              detailVC.productId = product.id
              navigationController?.pushViewController(detailVC, animated: true)
          }
      }
  }
