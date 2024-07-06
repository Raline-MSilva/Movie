//
//  APIClient.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Foundation

protocol APIClientProtocol: AnyObject {
    func fetchPopularMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchUpComingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchMovies(from endpoint: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
}

class APIClient: APIClientProtocol {
    
    private func getAPIKey() -> String? {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
            return keys?["apiKey"] as? String
        }
        return nil
    }
    
    func getURL(for endpoint: String) -> String? {
        guard let APIKey = getAPIKey() else { return nil }
        return "https://api.themoviedb.org/3/\(endpoint)?api_key=\(APIKey)&language=pt-BR&page=1"
        
    }
    
    // Fetch popular movies
    func fetchPopularMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        fetchMovies(from: "movie/popular", completion: completion)
    }
    
    // Fetch now playing movies
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        fetchMovies(from: "movie/now_playing", completion: completion)
    }
    
    // Fetch up comming movies
    func fetchUpComingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        fetchMovies(from: "movie/upcoming", completion: completion)
    }
    
    internal func fetchMovies(from endpoint: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        guard let urlString = getURL(for: endpoint),
              let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieEntityResults.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .noData:
            return "Dados inválidos"
        }
    }
}
