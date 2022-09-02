//
//  ResponseModel.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

// MARK: - OfficeData
public struct OfficeData: Codable {
    
    let address, capacity: String?
    let id: Int?
    let image: String?
    let images: [String]?
    let location: Location?
    let name: String?
    let rooms: Int?
    let space: String?
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

typealias OfficeArray = [OfficeData]
