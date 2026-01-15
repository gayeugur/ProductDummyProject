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
        var allSections: [ProductDetailSection] = [
            .imageCarousel(viewModel.imageCarouselVM),
            .productInfo(viewModel.productVM)
        ]
        allSections += viewModel.expandableSections.map { .expandable($0) }
        sections = allSections
        productDetailCollectionView.reloadData()
    }
    
    private func configure() {
        navigationItem.title = viewModel.productBrand
        productDetailCollectionView.delegate = self
        productDetailCollectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        productDetailCollectionView.register(
            UINib(nibName: "ImageCarouselCell", bundle: nil),
            forCellWithReuseIdentifier: ImageCarouselCell.reuseId
        )
        productDetailCollectionView.register(
            UINib(nibName: "ProductCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId
        )
        productDetailCollectionView.register(
            UINib(nibName: "ExpandableCell", bundle: nil),
            forCellWithReuseIdentifier: ExpandableCell.reuseId
        )
        productDetailCollectionView.register(
            UINib(nibName: "ExpandableSectionHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ExpandableSectionHeaderView"
        )
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
            cell.onItemTapped = { [weak self] in
                guard let self = self else { return }
                guard case .expandable(var vm) = self.sections[indexPath.section] else { return }
                vm.isExpanded.toggle()
                self.sections[indexPath.section] = .expandable(vm)
                self.productDetailCollectionView.reloadSections(IndexSet(integer: indexPath.section))
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
            return vm.isExpanded 
                ? CGSize(width: width, height: calculateExpandedHeight(for: vm, width: width))
                : CGSize(width: width, height: 0.1)
        }
    }
    
    private func calculateExpandedHeight(for vm: ExpandableSectionViewModel, width: CGFloat) -> CGFloat {
        let cardPadding: CGFloat = 16
        let labelPadding: CGFloat = 16
        let itemVerticalPadding: CGFloat = 4
        let itemSpacing: CGFloat = 2
        let collectionViewPadding: CGFloat = 8
        let minimumItemHeight: CGFloat = 20
        let minimumTotalHeight: CGFloat = 50
        
        let labelWidth = width - cardPadding - labelPadding
        let font = UIFont.systemFont(ofSize: 16)
        
        var totalHeight: CGFloat = vm.items.reduce(0) { height, item in
            let textHeight = item.text.heightWithConstrainedWidth(width: labelWidth, font: font)
            return height + max(textHeight + itemVerticalPadding, minimumItemHeight)
        }
        
        if vm.items.count > 1 {
            totalHeight += CGFloat(vm.items.count - 1) * itemSpacing
        }
        
        totalHeight += collectionViewPadding
        return max(totalHeight, minimumTotalHeight)
    }

    // Section header yüksekliği
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            return CGSize(width: UIScreen.main.bounds.width - 64, height: 36)
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
            return UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
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
        guard kind == UICollectionView.elementKindSectionHeader,
              case .expandable(let expandableVM) = sections[indexPath.section],
              let header = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: "ExpandableSectionHeaderView",
                  for: indexPath
              ) as? ExpandableSectionHeaderView else {
            return UICollectionReusableView()
        }
        
        header.configure(title: expandableVM.title, isExpanded: expandableVM.isExpanded)
        header.tapAction = { [weak self] in
            self?.toggleSection(at: indexPath.section)
        }
        return header
    }
    
    private func toggleSection(at index: Int) {
        guard case .expandable(var vm) = sections[index] else { return }
        vm.isExpanded.toggle()
        sections[index] = .expandable(vm)
        productDetailCollectionView.reloadSections(IndexSet(integer: index))
    }
}
