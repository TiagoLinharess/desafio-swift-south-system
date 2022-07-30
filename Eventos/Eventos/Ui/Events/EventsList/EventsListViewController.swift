//
//  EventsListViewController.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

final class EventsListViewController: UIViewController {

    private let customView: EventsListView
    
    init(viewModel: EventsListViewModelProtocol) {
        customView = .init(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }
}

private extension EventsListViewController {
    
    func setupView() {
        view = customView
    }
    
    func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Eventos"
    }
}
