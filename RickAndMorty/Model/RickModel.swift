//
//  RickModel.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import Foundation

///Это типо ключи для JSON Decoder.
// MARK: - RickModel
struct RickModel: Codable {
    let name: String?
    let image: String?
    let url: String
}
