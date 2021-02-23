//
//  CategoryManager.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 23/02/21.
//

import Foundation

struct CategoryManager {

    let CategoryURL = "https://api.rawg.io/api/games"
    
    func fetchCategory()  {
        let urlString = "\(CategoryURL)"
        performRequest(urlString : urlString)
    }
    
    func performRequest(urlString : String){
                if
                let url = URL(string: urlString){
                let session = URLSession(configuration : .default)
                let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
                
                task.resume()
                
            }
        }
        
        func handle(data : Data?, response : URLResponse?, error : Error?){
            if error != nil{
                print(error!)
                return
            }
            
            if let safeData = data{
                let dataString = String(data: safeData, encoding: .utf8)
                print(dataString!)
            }
            
        }
}
