//
//  ResponseModel.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

// MARK: - OfficeData
public struct OfficeData: Codable {
//    internal init(address: String?, capacity: String?, id: Int?, image: String?, images: [String]?, location: Location?, name: String?, rooms: Int?, space: String?) {
//        self.address = address
//        self.capacity = capacity
//        self.id = id
//        self.image = image
//        self.images = images
//        self.location = location
//        self.name = name
//        self.rooms = rooms
//        self.space = space
//    }
    
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
