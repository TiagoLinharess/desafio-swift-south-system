//
//  EventsCoordinator.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

final class EventsCoordinator: NSObject, Coordinator {
    
    var onFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController?.delegate = self
        presentEventsList()
    }
}

private extension EventsCoordinator {
    
    func presentEventsList() {
        let viewModel = EventsListViewModel()
        let viewController = EventsListViewController(viewModel: viewModel)
        
        viewModel.onSelectEvent = { [weak self] event in
            self?.presentEventDetail(with: event)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentEventDetail(with event: EventViewData) {
        let viewModel = EventDetailViewModel(event: event)
        let viewController = EventDetailViewController(viewModel: viewModel)
        
        viewModel.checkinDidMake = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension EventsCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController
            .transitionCoordinator?
            .viewController(forKey: .from)
        else { return }
        
        if fromViewController is EventsListViewController {
            onFinish?(self)
        }
    }
}
