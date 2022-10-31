//
//  SearchCompanyRequest.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import Foundation

struct SearchCompanyRequest: DataRequest {
    
    var searchText = String()
    
    private let apiKey: String = "company/search/autocomplete"

    var url: String {
        let baseURL: String = "https://welcomecenterestonia.ee"
        let path: String = "/index.php?"
        return baseURL + path
    }
    
    var queryItems: [String : String] {
        [
            "route": apiKey,
            "filter_text": searchText
        ]
    }
    
    var method: HTTPMethod {
        .post
    }
    
    func decode(_ data: Data) throws -> SearchCompanyResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        decoder.dateDecodingStrategy = .iso8601
        /*  TODO: need fix dateDecodingStrategy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        */
        
        let response = try decoder.decode(SearchCompanyResponse.self, from: data)
        
        return response
    }
}

