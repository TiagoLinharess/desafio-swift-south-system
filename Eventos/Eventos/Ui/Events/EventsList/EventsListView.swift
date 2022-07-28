//
//  EventsListView.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

final class EventsListView: UIView {
    
    private let colors = Flavor.shared.colors
    private let viewModel: EventsListViewModelProtocol
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        
        return stackview
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.startAnimating()
        loadingView.color = colors.background.onColor
        
        return loadingView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventsListTableViewCell.self, forCellReuseIdentifier: EventsListTableViewCell.identifier)
        
        return tableView
    }()
    
    init(viewModel: EventsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        setupBinding()
        self.viewModel.getEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: TableView methods
extension EventsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsListTableViewCell.identifier, for: indexPath) as? EventsListTableViewCell else { fatalError() }
        
        let event = viewModel.events[indexPath.row]
        cell.configure(event)
        return cell
    }
}

// MARK: Setup methods
extension EventsListView: ViewCode {
    
    func configureView() {
        backgroundColor = colors.background.color
    }
    
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(tableView)
        containerStackView.addArrangedSubview(loadingView)
    }
    
    func setupConstraints() {
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32)
        ])
    }
    
    func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

// MARK: View binding
private extension EventsListView {
    
    func setupBinding() {
        let _ = viewModel.viewStatus.subscribe { [weak self] published in
            guard let self = self, let status = published.element else { return }
            self.handle(with: status, onError: self.viewModel.getEvents)
        }
    }
    
    func handle(with viewStatus: ViewStatus, onError: @escaping () -> Void) {
        resetStatus()
        
        switch viewStatus {
        case .success:
            presentSuccess()
        case .loading:
            presentLoading()
        case .loadingMore:
            presentLoading()
        case let .error(error):
            presentError(message: error, action: onError)
        }
    }

    func resetStatus() {
        containerStackView.subviews.forEach({ $0.isHidden = true })
    }
    
    func presentSuccess() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func presentError(message: String? = nil, action: @escaping () -> Void) {
//        customErrorView.isHidden = false
//        customErrorView.setup(localizedMessage: message, imageName: nil, action: action)
    }
    
    func presentLoading() {
        loadingView.isHidden = false
    }
}
