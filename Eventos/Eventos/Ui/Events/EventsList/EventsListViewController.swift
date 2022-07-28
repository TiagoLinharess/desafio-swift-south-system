//
//  EventsListViewController.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

final class EventsListViewController<ViewModel>: UIViewController where ViewModel: EventsListViewModelProtocol {
    
    private let viewModel: ViewModel
    private let customView = EventsListView()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        viewModel.getEvents()
    }
    
    private func setupView() {
        view = customView
    }
    
    private func setupBinding() {
        let _ = viewModel.viewStatus.subscribe { [weak self] published in
            guard let self = self, let status = published.element else { return }
            self.customView.handle(with: status, onError: self.viewModel.getEvents)
        }
    }
}
