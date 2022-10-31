//
//  SearchCompanyViewModel.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import Foundation

protocol SearchCompanyViewModel {
    var companies: SearchCompanyResponse { get set }
    var onSearchCompanySucceed: (() -> Void)? { set get }
    var onSearchCompanyFailure: ((Error) -> Void)? { set get }
    func searchCompany(text: String?)
}

final class SearchCompanyDefaultViewModel: SearchCompanyViewModel {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var companies: SearchCompanyResponse = []
    
    var onSearchCompanySucceed: (() -> Void)?
    var onSearchCompanyFailure: ((Error) -> Void)?
    
    func searchCompany(text: String?) { // TODO: if empty, check ??
        var searchRequest = SearchCompanyRequest()
        searchRequest.searchText = text ?? ""
        networkService.request(searchRequest) { [weak self] result in
            switch result {
            case .success(let companies):
                self?.companies = companies
                self?.onSearchCompanySucceed?()
                print("parsed")
            case .failure(let error):
                self?.onSearchCompanyFailure?(error)
            }
        }
        
    }
    
    
}
