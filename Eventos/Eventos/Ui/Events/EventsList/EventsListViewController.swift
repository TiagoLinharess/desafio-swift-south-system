//
//  EventsListViewController.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

final class EventsListViewController: UIViewController {

    private let customView: EventsListView
    
    init() {
        customView = .init(viewModel: EventsListViewModel())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension EventsListViewController {
    func setupView() {
        view = customView
    }
}
