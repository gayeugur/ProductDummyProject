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
    // MARK: - ıboutlet
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    // MARK: - properties
    private let viewModel: ProductDetailViewModel
    private var sections: [ProductDetailSection] = []
    
    // MARK: - init
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        buildSections()
    }
    
    // MARK: - functions
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

// MARK: - UICollectionViewDataSource
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
                guard case .expandable(let vm) = self.sections[indexPath.section] else { return }
                vm.isExpanded.toggle()
                self.sections[indexPath.section] = .expandable(vm)
                self.productDetailCollectionView.reloadSections(IndexSet(integer: indexPath.section))
            }
            cell.configure(with: expandableVM)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width - 32
        let section = sections[indexPath.section]
        switch section {
        case .imageCarousel:
            return CGSize(width: width, height: 240)
        case .productInfo:
            return CGSize(width: width, height: 120)
        case .expandable(let vm):
            return CGSize(
                width: width,
                height: vm.isExpanded
                ? vm.expandedHeight(for: width)
                : 0.1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            let width = collectionView.bounds.width - 64
            return CGSize(width: width, height: 36)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionType = sections[section]
        switch sectionType {
        case .expandable:
            return UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        default:
            return .zero
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
        guard case .expandable(let vm) = sections[index] else { return }
        vm.isExpanded.toggle()
        sections[index] = .expandable(vm)
        productDetailCollectionView.reloadSections(IndexSet(integer: index))
    }
}
