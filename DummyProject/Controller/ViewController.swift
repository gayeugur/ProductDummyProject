//
//  ViewController.swift
//  DummyProject
//
//  Created by gayeugur on 6.01.2026.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    private let viewModel = ProductViewModel(
        networkManager: .shared
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        if let layout = productCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 150)
            layout.estimatedItemSize = .zero
            layout.minimumInteritemSpacing = 10
        }
        
        viewModel.fetchProducts()
    }
    
    private func configure() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        viewModel.delegate = self
        
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
    }

}

extension ViewController: ProductViewModelDelegate {
    func didUpdate(state: ProductsViewState) {
        self.productCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.product = viewModel.products[indexPath.item]
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let columns: CGFloat = 2
        let spacing: CGFloat = 10
        let inset: CGFloat = 16
        
        let totalHorizontalPadding =
        (inset * 2) + (spacing * (columns - 1))
        
        let width =
        (collectionView.bounds.width - totalHorizontalPadding)
        
        return CGSize(width: width, height: 181)
    }
}
