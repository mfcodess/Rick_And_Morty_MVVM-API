//
//  RickViewModel.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import Foundation

class RickViewModel {
    private var api = RickAPI()
    var character: RickModel?

    func fetchCharacter(completion: @escaping () -> Void) {
        api.fetchCharacter { [weak self] character in
            if let character = character {
                self?.character = character
                completion()
            }
        }
    }
}
