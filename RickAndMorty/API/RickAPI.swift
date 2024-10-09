//
//  RickAPI.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import Foundation

final class RickAPI {
    
    private let baseURL = "https://rickandmortyapi.com/api/character/48"

    func fetchCharacter(completion: @escaping (RickModel?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode(RickModel.self, from: data)
                completion(result)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
