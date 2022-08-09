//
//  OfficesWorker.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

protocol OfficesWorkingLogic: AnyObject {
    func getOffices (completion: @escaping ((Result<OfficeArray, Error>) -> Void))
}

final class OfficesWorker: OfficesWorkingLogic {
    func getOffices (completion: @escaping ((Result<OfficeArray, Error>) -> Void)) {
        
        NetworkManager().getOffice { result in
            switch result{
            case.success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
       
            
        }
                                 
        
    }
    
 
    
    
}

// 2.adım : network modelden gelen veriyi result a alıyor respons ile interactor a gönderiyor
