//
//  DisneyDataService.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/6/23.
//

import Foundation

struct DisneyDataService {
    func executeRequest<T: Decodable>(withUrl url: URL, completion: @escaping (T?) -> ()) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let decoded = try! decoder.decode(T.self, from: data)
                
                completion(decoded)
            }
        }.resume()
    }
}
