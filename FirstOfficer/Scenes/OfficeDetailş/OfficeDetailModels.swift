//
//  OfficeDetailModels.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum OfficeDetail {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let office : OfficeData?
        }
        
        struct ViewModel {
            let address, capacity: String?
            let id: Int?
            let image: String?
            let images: [String]?
            let location: Location?
            let name: String?
            let rooms: String?
            let space: String?
        }
        
    }
    
}
// swiftlint:enable nesting
