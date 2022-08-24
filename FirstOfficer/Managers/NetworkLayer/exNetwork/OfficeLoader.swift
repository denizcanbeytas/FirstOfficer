//
//  OfficeLoader.swift
//  FirstOfficer
//
//  Created by Deniz on 6.08.2022.
//

import Foundation

public protocol OfficeLoader {
    func load(completion: @escaping((Result<[OfficeData], Error>) -> Void))
}
