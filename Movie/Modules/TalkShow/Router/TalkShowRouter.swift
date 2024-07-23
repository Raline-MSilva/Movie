//
//  TalkShowRouter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import UIKit

class TalkShowRouter: TalkShowRouterProtocol {
    static func createTalkShowModule() -> UIViewController {
        let talkShowViewController = TalkShowViewController()
        let presenter: TalkShowPresenterProtocol & TalkShowInteractorOutputProtocol = TalkShowPresenter()
        let interactor: TalkShowInteractorInputProtocol = TalkShowInteractor()
        let router: TalkShowRouterProtocol = TalkShowRouter()
        
        talkShowViewController.talkShowPresenter = presenter
        presenter.talkShowView = talkShowViewController
        presenter.talkShowInteractorInput = interactor
        presenter.talkShowRouter = router
        interactor.talkShowInteractorOutput = presenter
        
        return talkShowViewController
    }
    
    func navigateToTalkShow(from view: TalkShowViewProtocol, with talkShow: TalkShowEntity) {
//        let movieDetailsVC = TalkShowDetailsViewController(movie: movie)
//        if let viewController = view as? UIViewController {
//            viewController.navigationController?.pushViewController(movieDetailsVC, animated: true)
//        }
        
    }
    
    
}
