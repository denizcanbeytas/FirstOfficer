//
//  MapViewModels.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

enum MapView {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            // For presenter
            var OfficesForMap : [OfficeData]
        }
        
        struct ViewModel {
            // For VC
            struct OfficesForMap {
                let id: Int?
                let latitude: Double?
                let longidute: Double?
                let name: String?
            }
            let officesForMapArray : [MapView.Fetch.ViewModel.OfficesForMap]
        }
        
    }
    
}

