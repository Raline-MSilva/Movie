//
//  Network.swift
//  Movie
//
//  Created by Raline Maria da Silva on 21/11/22.
//

import Foundation

struct Network {
    
    private func getAPIKey() -> String? {
           var keys: NSDictionary?
           if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                   keys = NSDictionary(contentsOfFile: path)
                   return keys?["apiKey"] as? String
               }
           return nil
       }
    
    func getURLPopularMovies() -> String {
        guard let APIKey = getAPIKey() else { return String() }
        return "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey)&language=pt-BR&page=1"
        
    }
    
    func fetchPopularMovies(_ completion: @escaping ([Movie]) -> ()) {
        let url = URL(string: getURLPopularMovies())!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieResults.self, from: data)
                completion(result.results)
            } catch {
                print("Erro, não foi possível decodificar o JSON")
            }
        }
        task.resume()
    }
}
