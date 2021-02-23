//
//  RawModels.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 23/02/21.
//

import Foundation

struct GamesModels : Codable{
    let count : Int
    let results : [GameData]
}

struct GameData : Codable{
    let gameId : Int
    let gamePoster : String
    let gameTitle : String
    let gameReleasedDate : String
    let gameRating : Float
    
    enum CodingKeys: String, CodingKey{
        
        case gameId = "id"
        case gamePoster = "background_image"
        case gameTitle = "name"
        case gameReleasedDate = "released"
        case gameRating = "rating"
    }
}

struct GameDataById : Codable{
    let id : Int
    let description : String
}
