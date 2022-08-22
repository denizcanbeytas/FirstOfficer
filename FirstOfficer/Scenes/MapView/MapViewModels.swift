//
//  MapViewModels.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum MapView {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            var OfficesForMap : [OfficeData]
        }
        
        struct ViewModel {
            struct OfficesForMap {
                let id: Int
                let latitude: Double
                let longidute: Double
                let name: String
            }
            var officesForMapArray : [OfficesForMap]
        }
        
    }
    
}
// swiftlint:enable nesting
