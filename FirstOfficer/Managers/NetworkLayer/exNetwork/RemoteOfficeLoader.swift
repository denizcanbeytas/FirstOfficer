//
//  RemoteOfficeLoader.swift
//  FirstOfficer
//
//  Created by Deniz on 6.08.2022.
//

import Foundation

public class RemoteOfficeLoader: OfficeLoader {
    
    private let url : URL
    private let client : HTTPClient
    
    internal init(url: URL, client: HTTPClient){
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping ((Result<[OfficeData], Error>) -> Void)) {
        client.get(from: url) { result in
            switch result {
            case let .success((data, _)):
                do{
                    let office = try JSONDecoder().decode([OfficeData].self, from: data)
                    completion(.success(office))
                } catch {
                    completion(.failure(error))
                }
            case let.failure(error):
                completion(.failure(error))
            }
        }
    }
}
