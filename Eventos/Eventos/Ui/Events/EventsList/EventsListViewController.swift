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
        setupNavigationBar()
    }
}

private extension EventsListViewController {
    func setupView() {
        view = customView
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let background = Flavor.shared.colors.background
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: background.onColor,
            .font: Flavor.shared.fonts.quickSandBold.withSize(28)
        ]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Eventos"
        
        appearance.titleTextAttributes = attributes
        appearance.largeTitleTextAttributes = attributes
        appearance.backgroundColor = background.color

        navigationItem.standardAppearance = appearance
    }
}
