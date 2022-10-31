//
//  ViewController.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import UIKit

class ViewController: UIViewController {

  //  var companies: [CompanyItem] = []
    private let networkService: NetworkService = DefaultNetworkService()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        fetchCompany()
    }

    private func fetchCompany() {
        var request = SearchCompanyRequest()
        request.searchText = "xolo"
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let companies):
              //  self?.companies = companies
              //  self?.onFetchMovieSucceed?()
                print("parsed")
            case .failure(let error):
                print("errrorr")
              //  self?.onFetchMovieFailure?(error)
            }
        }
    }
    
}

