//
//  TalkShowInteractor.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import Foundation

class TalkShowInteractor: TalkShowInteractorInputProtocol {
    var talkShowInteractorOutput: TalkShowInteractorOutputProtocol?
    var talkShows: [TalkShowEntity] = []
    private let networkApiClient: APIClientProtocol = APIClient()
    
    func fetchListPopularTalkShows() {
        networkApiClient.fetchPopularTalkShows { result in
            switch result {
            case .success(let talkShows):
                self.talkShows = talkShows
                //aqui me retorna eles
                self.talkShowInteractorOutput?.didFetchPopularTalkShows(talkShows)
            case .failure(let error):
                self.talkShowInteractorOutput?.didFailWithError(error)
            }
        }
    }
    
    func fetchListAiringToday() {
        networkApiClient.fetchAiringTodayTalkShows { result in
            switch result {
            case .success(let talkShows):
                self.talkShows = talkShows
                self.talkShowInteractorOutput?.didFetchAiringTodayTalkShows(talkShows)
            case .failure(let error):
                self.talkShowInteractorOutput?.didFailWithError(error)
            }
        }
        
    }
    
    func fetchListOnTheAir() {
        networkApiClient.fetchOnTheAirTalkShows { result in
            switch result {
            case .success(let talkShows):
                self.talkShows = talkShows
                self.talkShowInteractorOutput?.didFetchOnTheAirTalkShows(talkShows)
            case .failure(let error):
                self.talkShowInteractorOutput?.didFailWithError(error)
            }
        }
        
    }
}
