//
//  SearchCompanyResponse.swift
//  wce
//
//  Created by Can Babaoğlu on 31.10.2022.
//

import Foundation

struct SearchCompanyItem: Codable {
    let companyID, name: String?

    enum CodingKeys: String, CodingKey {
        case companyID = "company_id"
        case name
    }
}

typealias SearchCompanyResponse = [SearchCompanyItem]
