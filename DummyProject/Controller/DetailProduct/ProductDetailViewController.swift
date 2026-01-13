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

// Section header gösterimi (sadece dosya sonunda bir kez tanımlı olacak)

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

        // Section header register
        let headerNib = UINib(nibName: "ExpandableSectionHeaderView", bundle: nil)
        productDetailCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExpandableSectionHeaderView")
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
        case .expandable(let expandableVM):
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
                // Her item için yaklaşık yükseklik
                let itemHeight: CGFloat = 44
                let total = CGFloat(vm.items.count) * itemHeight
                return CGSize(width: width, height: total)
            } else {
                // Hiç item görünmesin (sadece header)
                return CGSize(width: width, height: 0.1)
            }
        }
    }

    // Section header yüksekliği
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            return CGSize(width: UIScreen.main.bounds.width - 64, height: 44)
        default:
            return .zero
        }
    }
    // Remove spacing between header and section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            // Sadece alt boşluk bırak, header ile cell arası boşluk olmasın
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            return 0 // Header ile cell arası boşluk olmasın
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let section = sections[indexPath.section]
        switch section {
        case .expandable(let expandableVM):
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExpandableSectionHeaderView", for: indexPath) as! ExpandableSectionHeaderView
            header.configure(title: expandableVM.title, isExpanded: expandableVM.isExpanded)
            header.tapAction = { [weak self] in
                guard let self = self else { return }
                guard case .expandable(var vm) = self.sections[indexPath.section] else { return }
                vm.isExpanded.toggle()
                self.sections[indexPath.section] = .expandable(vm)
                self.productDetailCollectionView.reloadSections(IndexSet(integer: indexPath.section))
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
