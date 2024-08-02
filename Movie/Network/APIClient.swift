//
//  APIClient.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Combine
import Foundation

protocol APIClientProtocol: AnyObject {
    func fetchPopularMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchUpComingMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func fetchMovies(from endpoint: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    
    func fetchPopularTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void)
    func fetchTalkShow(from endpoint: String, completion: @escaping (Result<[TalkShowEntity], Error>) -> Void)
    func fetchAiringTodayTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void)
    func fetchOnTheAirTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void)
    //func fetchNowPlayingMovieTrailers(completion: @escaping (Result<[Trailer], Error>) -> Void)
    //func fetchUpcomingMovieTrailers(completion: @escaping (Result<[Trailer], Error>) -> Void)
    func fetchMovieTrailers(for movieID: Int, completion: @escaping (Result<[Trailer], Error>) -> Void)
    func fetchMovieTrailersPublisher(for movieID: Int) -> AnyPublisher<[Trailer], Error>
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
    
    // Fetch popular talk shows
    func fetchPopularTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void) {
        fetchTalkShow(from: "tv/popular", completion: completion)
    }
    
    // Fetch airing today talk shows
    func fetchAiringTodayTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void) {
        fetchTalkShow(from: "tv/airing_today", completion: completion)
    }
    
    // Fetch on the air talk shows
    func fetchOnTheAirTalkShows(completion: @escaping (Result<[TalkShowEntity], Error>) -> Void) {
        fetchTalkShow(from: "tv/on_the_air", completion: completion)
    }
    
    //    func fetchNowPlayingMovieTrailers(completion: @escaping (Result<[Trailer], Error>) -> Void) {
    //        fetchMovieTrailers(for: 786892, completion: completion)
    //    }
    //
    //    func fetchUpcomingMovieTrailers(completion: @escaping (Result<[Trailer], Error>) -> Void) {
    //        fetchMovieTrailers(for: 786892, completion: completion)
    //    }
    
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
    
    internal func fetchTalkShow(from endpoint: String, completion: @escaping (Result<[TalkShowEntity], Error>) -> Void) {
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
                let result = try JSONDecoder().decode(TalkShowEntityResults.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovieTrailers(for movieID: Int, completion: @escaping (Result<[Trailer], Error>) -> Void) {
        guard let urlString = getURL(for: "movie/\(movieID)/videos"),
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
                let result = try JSONDecoder().decode(VideoResults.self, from: data)
                let trailers = result.results.filter { $0.type == "Trailer" }.map {
                    Trailer(name: $0.name, videoURL: "https://www.youtube.com/watch?v=\($0.key)")
                }
                completion(.success(trailers))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovieTrailersPublisher(for movieID: Int) -> AnyPublisher<[Trailer], Error> {
        guard let urlString = getURL(for: "movie/\(movieID)/videos"),
              let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> [Trailer] in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidURL
                }
                let result = try JSONDecoder().decode(VideoResults.self, from: data)
                return result.results.filter { $0.type == "Trailer" }.map {
                    Trailer(name: $0.name, videoURL: "https://www.youtube.com/watch?v=\($0.key)")
                }
            }
            .eraseToAnyPublisher()
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
