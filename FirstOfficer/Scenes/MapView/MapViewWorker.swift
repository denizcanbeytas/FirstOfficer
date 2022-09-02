//
//  MapViewWorker.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol MapViewWorkingLogic: AnyObject {
    func fetchOfficeForMap(_ completion: @escaping ((Result<OfficeArray, Error>) -> Void))
}

final class MapViewWorker: MapViewWorkingLogic {
    func fetchOfficeForMap(_ completion: @escaping ((Result<OfficeArray, Error>) -> Void)) {
        NetworkManager().getOffice { result in
            switch result{
            case.success(let response):
                completion(.success(response))
            case .failure(let error):
                //completion(.failure(error))
                switch error {
                case .badRequest:
                    print("BadRequest: \(error.localizedDescription)")
                case .serverError:
                    print("serverError: \(error.localizedDescription)")
                case .tooManyRequest:
                    print("tooManyRequest: \(error.localizedDescription)")
                case .decoding:
                    print("decoding: \(error.localizedDescription)")
                case .unauthorized:
                    print("unauthorized: \(error.localizedDescription)")
                default:
                    break
                }
            }
        }
    }
}
