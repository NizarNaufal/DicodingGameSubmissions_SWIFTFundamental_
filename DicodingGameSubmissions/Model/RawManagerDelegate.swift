//
//  RawManagerDelegate.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 23/02/21.
//

import Foundation

protocol GameManagerDelegate{
    
    func didUpdateGame(_ gameManager : GameManager, game : GamesModels)
    func didFailWithError(error: Error)
}

struct GameManager{
    let gameURL = "https://api.rawg.io/api/games"
    
    var delegate: GameManagerDelegate?
    
    func fetchGames() {
        let urlString = "\(gameURL)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let games = self.parseJSON(safeData) {
                        self.delegate?.didUpdateGame(self, game: games)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ gameData: Data) -> GamesModels? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(GamesModels.self, from: gameData)
            let count = decodedData.count
            let results = decodedData.results
            let games = GamesModels(count: count, results: results)
            return games
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
