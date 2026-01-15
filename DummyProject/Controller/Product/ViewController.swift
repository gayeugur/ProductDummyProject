//
//  ViewController.swift
//  DummyProject
//
//  Created by gayeugur on 6.01.2026.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - ıboutlet
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    // MARK: - properties
    private let viewModel = ProductViewModel(
        networkManager: .shared
    )
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetchProducts()
        navigationItem.title = "Products"
    }
    
    // MARK: - functions
    private func configure() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        viewModel.delegate = self
        
        productCollectionView.register(
            UINib(nibName: "ProductCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId
        )
    }
    
}

// MARK: - ProductViewModelDelegate
extension ViewController: ProductViewModelDelegate {
    func didUpdate(state: ProductsViewState) {
        switch state {
        case .idle:
            break
            
        case .loading:
            showLoading()
            
        case .loaded:
            hideLoading()
            productCollectionView.reloadData()
            
        case .error(let message):
            hideLoading()
            showError(message)
        }
    }
    
    private func showError(_ message: String) {
        let popup = PopupConfiguration(title: "Hata",
                                       message: "Beklenmeyen bir hata oluştu",
                                       actions: [
                                        PopupAction(title: "İptal", style: .secondary, handler: nil),
                                        PopupAction(title: "Tekrar Dene", style: .destructive) {
                                            self.viewModel.fetchProducts()
                                        }
                                       ])
        let vm = PopupViewModel(config: popup)
        let vc = PopupViewController(viewModel: vm)
        present(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellVM = viewModel.cellViewModel(at: indexPath.item)
        cell.configure(with: cellVM)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.item]
        navigateToDetail(with: product)
    }
    
    private func navigateToDetail(with product: Product) {
        let vm = ProductDetailViewModel(product: product)
        let detailVC = ProductDetailViewController(viewModel: vm)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 24
        let inset: CGFloat = 16
        let totalHorizontalPadding = (inset * 2) + (spacing * (columns - 1))
        let width = (collectionView.bounds.width - totalHorizontalPadding)
        return CGSize(width: width, height: 120)
    }
}
