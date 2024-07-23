//
//  TalkShowViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import UIKit

class TalkShowViewController: UIViewController, TalkShowViewProtocol {
    internal var talkShowPresenter: TalkShowPresenterProtocol?
    private var talkShowView: TalkShowView?
    
    internal override func loadView() {
        talkShowView = TalkShowView()
        //talkShowView?.delegate = self
        view = talkShowView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        talkShowPresenter?.didLoadListTalkShows()
        navigationItem.backButtonTitle = "Voltar"
    }
    
    func showListPopularTalkShows(_ talkShows: [TalkShowEntity]) {
        talkShowView?.popularTalkShow = talkShows
        
    }
    
    func showListAiringTodayTalkShows(_ talkShows: [TalkShowEntity]) {
        talkShowView?.airingTodayTalkShow = talkShows
    }
    
    func showListOnTheAirTalkShows(_ talkShows: [TalkShowEntity]) {
        talkShowView?.onTheAirTalkShow = talkShows
    }
    
    internal func showError(_ error: Error) {
        print("Erro: \(error.localizedDescription)")
    }
}
