//
//  ProductDetailViewController.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

import UIKit

enum ProductDetailSection {
    case imageCarousel(ImageCarouselViewModel)
    case productInfo(ProductCellViewModel)
    case expandable(ExpandableSectionViewModel)
}

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    private let viewModel: ProductDetailViewModel
    private var sections: [ProductDetailSection] = []
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        buildSections()
    }
    
    private func buildSections() {
        sections = [
            .imageCarousel(viewModel.imageCarouselVM),
            .productInfo(viewModel.productVM)
        ]
        // Her bir expandable section için ayrı section ekle
        for expandableVM in viewModel.expandableSections {
            sections.append(.expandable(expandableVM))
        }
        productDetailCollectionView.reloadData()
    }
    
    private func configure() {
        navigationItem.title = viewModel.productBrand
        productDetailCollectionView.delegate = self
        productDetailCollectionView.dataSource = self
        
        productDetailCollectionView.register(
            UINib(nibName: "ImageCarouselCell", bundle: nil),
            forCellWithReuseIdentifier: ImageCarouselCell.reuseId
        )
        
        productDetailCollectionView.register(
            UINib(nibName: "ProductCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        
        productDetailCollectionView.register(
            UINib(nibName: "ExpandableCell", bundle: nil),
            forCellWithReuseIdentifier: ExpandableCell.reuseId)
        
    }
    
}

extension ProductDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .imageCarousel(let carouselVM):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCarouselCell.reuseId,
                for: indexPath
            ) as! ImageCarouselCell
            cell.configure(with: carouselVM)
            return cell
        case .productInfo(let productVM):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.reuseId,
                for: indexPath
            ) as! ProductCollectionViewCell
            cell.configure(with: productVM, isHiddenImage: true)
            return cell
        case .expandable(var expandableVM):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExpandableCell.reuseId,
                for: indexPath
            ) as! ExpandableCell
            cell.onItemTapped = { [weak self, weak cell] in
                guard let self = self else { return }
                guard case .expandable(var vm) = self.sections[indexPath.section] else { return }
                vm.isExpanded.toggle()
                self.sections[indexPath.section] = .expandable(vm)
                cell?.configure(with: vm)
                self.productDetailCollectionView.performBatchUpdates(nil)
            }
            cell.configure(with: expandableVM)
            return cell
        }
    }
    
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let section = sections[indexPath.section]
        switch section {
        case .imageCarousel:
            return CGSize(width: width, height: 240)
        case .productInfo:
            return CGSize(width: width, height: 120)
        case .expandable(let vm):
            if vm.isExpanded {
                // Her item için yaklaşık yükseklik + başlık
                let itemHeight: CGFloat = 44
                let headerHeight: CGFloat = 44
                let total = headerHeight + CGFloat(vm.items.count) * itemHeight
                return CGSize(width: width, height: total)
            } else {
                // Sadece başlık görünsün (collapse)
                return CGSize(width: width, height: 44)
            }
        }
    }
}
