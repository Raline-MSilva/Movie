//
//  TalkShowPresenter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import Foundation

class TalkShowPresenter: TalkShowPresenterProtocol {
    var talkShowView: TalkShowViewProtocol?
    var talkShowInteractorInput: TalkShowInteractorInputProtocol?
    var talkShowRouter: TalkShowRouterProtocol?
    
    func didLoadListTalkShows() {
        talkShowInteractorInput?.fetchListPopularTalkShows()
        talkShowInteractorInput?.fetchListAiringToday()
        talkShowInteractorInput?.fetchListOnTheAir()
    }
    
    func didSelectCell(at indexPath: IndexPath, with talkShow: TalkShowEntity) {
        if let talkShows = talkShowInteractorInput?.talkShows {
            let talkShow = talkShows[indexPath.row]
            
            guard let talkShowView = talkShowView else { return }
            talkShowRouter?.navigateToTalkShow(from: talkShowView, with: talkShow)
        }
    }
    
}

extension TalkShowPresenter: TalkShowInteractorOutputProtocol {

    func didFetchPopularTalkShows(_ talkShows: [TalkShowEntity]) {
        talkShowView?.showListPopularTalkShows(talkShows)
    }
    
    func didFetchAiringTodayTalkShows(_ talkShow: [TalkShowEntity]) {
        talkShowView?.showListAiringTodayTalkShows(talkShow)
    }
    
    func didFetchOnTheAirTalkShows(_ talkShow: [TalkShowEntity]) {
        talkShowView?.showListOnTheAirTalkShows(talkShow)
    }
    
    func didFailWithError(_ error: Error) {
        talkShowView?.showError(error)
    }
    
    
}
