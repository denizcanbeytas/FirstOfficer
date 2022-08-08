//
//  HTTPClient.swift
//  FirstOfficer
//
//  Created by Deniz on 6.08.2022.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping ((Result<(Data, HTTPURLResponse),Error>) -> Void))

}

class API: HTTPClient {
    func get(from url: URL, completion: @escaping ((Result<(Data, HTTPURLResponse), Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(error ?? NSError(domain: "unknown error", code: -1)))
                return
            }
            completion(.success((data,response)))
        }
    }
}
