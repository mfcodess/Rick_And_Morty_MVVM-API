//
//  RickViewModel.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import Foundation

final class RickViewModel {
  
    private var api = RickAPI()
    
    var character: RickModel?

    func fetchCharacter(completion: @escaping () -> Void) {
        api.fetchCharacter { [weak self] character in
           
            if let character = character {
                self?.character = character
                print("Данные о персонаже загружены: \(character.name)")
                completion()
            } else {
                print("Не удалось загрузить данные о персонаже.")
                completion() 
            }
        }
    }
}
