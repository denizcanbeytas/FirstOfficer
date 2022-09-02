//
//  Networker.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation
protocol NetworkManagerProtocol{
    func getOffice(completion: @escaping ((Result<OfficeArray,NetworkingErrors>) -> Void))
}



// completion: @escaping (OfficeResponse?) -> Void
struct NetworkManager: NetworkManagerProtocol{
    
    
    func getOffice(completion: @escaping ((Result<OfficeArray,NetworkingErrors>) -> Void)){
        
        let url = URL(string: "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json")!
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                do {
                    let officeJson = try decoder.decode(OfficeArray.self, from: data)
                    completion(.success(officeJson))
                    
                } catch (_){
                    // if decoding does not work
                    completion(.failure(NetworkingErrors.decoding))
                }
            } else if response.statusCode == 400 {
                // we can using localizedDescription, because we give NetworkingErrors by error in dataTask parameter
                completion(.failure(.badRequest))
            } else if response.statusCode == 401 {
                completion(.failure(.unauthorized))
            } else if response.statusCode == 429 {
                completion(.failure(.tooManyRequest))
            } else if response.statusCode == 500 {
                completion(.failure(.serverError))
            } else {return}
            
        }
        task.resume()
    }
    
}

enum NetworkingErrors: Error {
    case badRequest
    case unauthorized
    case tooManyRequest
    case serverError
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to a missing or misconfigured parameter."
        case .unauthorized:
            return "Your API key was missing from the request, or wasn't correct."
        case .tooManyRequest:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while."
        case .serverError:
            return "Something went wrong on our side."
        case .decoding:
            return "Data could not decoding"
        default:
            return "Something went wrong."
        }
    }
}

// -> 1.adım
