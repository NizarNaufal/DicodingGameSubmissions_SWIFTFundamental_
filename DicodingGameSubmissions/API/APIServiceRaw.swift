//
//  APIServiceRaw.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 23/02/21.
//

import Foundation
class APIServiceRaw {
    static let shared = APIServiceRaw()
    
    let BASE_URL_PROD_RAW = "https://api.rawg.io/api"
    let CATEGORY = "/games"
    
    func getCategory(){
        guard let url = URL(string : BASE_URL_PROD_RAW + CATEGORY) else{return}
               let task = URLSession.shared.dataTask(with: url){(data, response, error) in
                   if let error = error{
                       print(error.localizedDescription)
                       return
                   }
                   if let response = response{
                       print(response)
                   }
                   if let data = data{
                       do {
                           let json = try JSONDecoder().decode(GameData.self, from: data)
                           print(json)
                       } catch {
                           print(error.localizedDescription)
                           return
                       }
                      
                   }
               }
               task.resume()
           }
}
