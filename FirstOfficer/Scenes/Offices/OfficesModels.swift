//
//  OfficesModels.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Offices {
    
    enum Fetch {
        
        struct Request {}
    
        struct Response {
            let offices: OfficeArray
        }
        
        struct ViewModel {
            var offices:[Offices.Fetch.ViewModel.Office]
            
            struct Office {
                let address, capacity: String?
                let id: String? //
                let image: String?
                let images: [String]?
                let location: Location?
                let name: String?
                let rooms: String?
                let space: String?
            }
        }
    }
}

struct itemsForFiltering {
    let firstItem: String?
    let secondItem: [String]?
}
// swiftlint:enable nesting
