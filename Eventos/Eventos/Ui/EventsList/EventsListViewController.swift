//
//  EventsListViewController.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

class EventsListViewController<ViewModel>: UIViewController where ViewModel: EventsListViewModelProtocol {
    
    private let viewModel: ViewModel
    
    private let customView = EventsListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
