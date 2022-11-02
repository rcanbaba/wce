//
//  ViewController.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private var viewModel: SearchCompanyViewModel
    private var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchResultsCollectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
          let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
          let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 60 : 80)
          )
          let itemCount = isPhone ? 1 : 3
          let item = NSCollectionLayoutItem(layoutSize: size)
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
          section.interGroupSpacing = 4
          return section
        })
        
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCellID")
       // collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        
        
        return collectionView
    }()
    
    init(viewModel: SearchCompanyViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureUI()
        searchCompanies()
        bindViewModel()
        view.backgroundColor = UIColor.white
    }

    private func configureUI() {
        searchResultsCollectionView.backgroundColor = UIColor.white
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(150)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Videos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func searchCompanies(text: String? = nil) {
        viewModel.searchCompany(text: text)
    }
    
    private func bindViewModel() {
        viewModel.onSearchCompanySucceed = { [weak self] in
            DispatchQueue.main.async {
                print(self?.viewModel.companies)
            }
        }
        
        viewModel.onSearchCompanyFailure = { error in
            print(error)
        }
        
    }
    
    
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCompanies(text: searchController.searchBar.text)
    // TODO: search text e göre update et vs vs
       // videoList = filteredVideos(for: searchController.searchBar.text)
        searchResultsCollectionView.reloadData()
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCellID", for: indexPath) as! SearchCollectionViewCell
        cell.infoLabel.text = viewModel.companies[indexPath.item].name
        return cell
    }
    
    
}
