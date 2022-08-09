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
            
        }
        
        struct ViewModel {
            let images: [String]?
        }
        
    }
    
}
// swiftlint:enable nesting
