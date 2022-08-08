//
//  Networker.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation
protocol NetworkManagerProtocol{
    func getOffice(completion: @escaping ((Result<OfficeArray,Error>) -> Void))
}



// completion: @escaping (OfficeResponse?) -> Void
struct NetworkManager: NetworkManagerProtocol{
    
    
    func getOffice(completion: @escaping ((Result<OfficeArray,Error>) -> Void)){
    let fullUrl = "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json"
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
        }
            let officeJson = try? JSONDecoder().decode(OfficeArray.self, from: data)
            if let officeJson = officeJson {
            completion(.success(officeJson))
            }
            
            
        }
        .resume()
        
    }
    
}


// -> 1.adım
