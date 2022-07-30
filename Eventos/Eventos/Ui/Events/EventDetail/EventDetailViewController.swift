//
//  EventDetailViewController.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    private let customView: EventDetailView
    
    init(viewModel: EventDetailViewModelProtocol) {
        self.customView = .init(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
}
