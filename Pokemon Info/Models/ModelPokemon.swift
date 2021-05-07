//
//  ModelPokemon.swift
//  Pokemon Info
//
//  Created by Daniel Silva on 02/05/2021.
//

import Foundation
import UIKit

struct ModelPokemon: Codable {
    
    var id: Int?
    var name: String?
    var sprites: ModelPokemonImages?
    var stats: [ModelStats]?
    var weight: Int?
}
