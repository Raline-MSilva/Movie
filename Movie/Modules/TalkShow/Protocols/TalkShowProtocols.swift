//
//  Protocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import UIKit

protocol TalkShowViewProtocol: AnyObject {
    var talkShowPresenter: TalkShowPresenterProtocol? { get set }
    func showListPopularTalkShows(_ talkShows: [TalkShowEntity])
    func showListAiringTodayTalkShows(_ talkShows: [TalkShowEntity])
    func showListOnTheAirTalkShows(_ talkShows: [TalkShowEntity])
    func showError(_ error: Error)
}

protocol TalkShowPresenterProtocol: AnyObject {
    var talkShowView: TalkShowViewProtocol? { get set }
    var talkShowInteractorInput: TalkShowInteractorInputProtocol? { get set }
    var talkShowRouter: TalkShowRouterProtocol? { get set }
    func didLoadListTalkShows()
    func didSelectCell(at indexPath: IndexPath, with talkShow: TalkShowEntity)
}

protocol TalkShowInteractorInputProtocol: AnyObject {
    var talkShowInteractorOutput: TalkShowInteractorOutputProtocol? { get set }
    var talkShows: [TalkShowEntity] { get set }
    func fetchListPopularTalkShows()
    func fetchListAiringToday()
    func fetchListOnTheAir()
}

protocol TalkShowInteractorOutputProtocol: AnyObject {
    func didFetchPopularTalkShows(_ talkShow: [TalkShowEntity])
    func didFetchAiringTodayTalkShows(_ talkShow: [TalkShowEntity])
    func didFetchOnTheAirTalkShows(_ talkShow: [TalkShowEntity])
    func didFailWithError(_ error: Error)
}

protocol TalkShowRouterProtocol: AnyObject {
    static func createTalkShowModule() -> UIViewController
    func navigateToTalkShow(from view: TalkShowViewProtocol, with talkShow: TalkShowEntity)
}
