//
//  FullScreenModels.swift
//  FirstOfficer
//
//  Created by Deniz on 9.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum FullScreen {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let officeImages : OfficeData?
            let selectedIndex: Int?
            
        }
        
        struct ViewModel {
 
             let images: [String]?
             let selectedIndex: Int?
//            let address, capacity: String?
//            let id: Int?
             let image: String?
//            let location: Location?
//            let name: String?
//            let rooms: String?
//            let space: String?
        }
        
    }
    
}
// swiftlint:enable nesting
