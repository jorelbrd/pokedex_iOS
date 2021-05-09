//
//  Pokemon.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/7/21.
//

import UIKit

public class Pokemon {
    //DATA DETAILS POKEMON
    var name: String?
    var image: UIImage?
    var id: Int?
    var order: Int?
    var specieUrl: String?
    var color: UIColor?
    var description: String?
    var types: [String]? = []
    var moves: [Moves]? = []
    var levelEvolution: Int?
    var nextEvolution: [PokemonData]? = []
    
    
    
    //STATS
    var hp: Int?
    var atk: Int?
    var def: Int?
    var satk: Int?
    var sdef: Int?
    var spd: Int?
    
    
    //MOVES
    struct Moves {
        var name: String?
        var level: Int?
    }
    
    
    
    //SET COLOR SELF CLASS
    public func setColor(stringColor: String) -> UIColor {
        switch stringColor {
        case TypeElement.water.rawValue:
            return UIColor.systemBlue
        case TypeElement.fire.rawValue:
            return UIColor.systemOrange
        case TypeElement.bug.rawValue:
            return UIColor.systemGreen
        case TypeElement.electric.rawValue:
            return UIColor.systemYellow
        case TypeElement.dark.rawValue:
            return UIColor.lightGray
        case TypeElement.grass.rawValue:
            return UIColor.systemGreen
        case TypeElement.ground.rawValue:
            return UIColor.brown
        case TypeElement.fairy.rawValue:
            return UIColor.systemPink
        case TypeElement.steel.rawValue:
            return UIColor.cyan
        case TypeElement.poison.rawValue:
            return UIColor.systemPurple
        default:
            return UIColor.systemGray
        }
    }
    
    //ENUM COLECTION TYPES POKEMONS
    enum TypeElement: String {
        case grass = "grass"
        case fire = "fire"
        case water = "water"
        case ghost = "ghost"
        case flying = "flying"
        case dark = "dark"
        case bug = "bug"
        case poison = "poison"
        case ground = "ground"
        case electric = "electric"
        case normal = "normal"
        case rock = "rock"
        case dragon = "dragon"
        case steel = "steel"
        case psychic = "psychic"
        case fairy = "fairy"
        case ice = "ice"
    }
}

//RESUTS ARRAY FOR POKEDEX
public class PokemonData: Pokemon {
    var url: String?
}


//RESULT URL BASE POKE API
public class DataResult {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonData]?
    
}



