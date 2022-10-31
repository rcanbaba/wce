//
//  ViewController.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var viewModel: SearchCompanyViewModel
    
    init(viewModel: SearchCompanyViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchCompanies()
        bindViewModel()
        view.backgroundColor = UIColor.red
        
    }

    private func configureUI() {
        // TODO: snapkit integration
    }
    
    private func searchCompanies(text: String = "xolo") {
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

