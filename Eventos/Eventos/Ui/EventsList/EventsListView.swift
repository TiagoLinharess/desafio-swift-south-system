//
//  EventsListView.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

class EventsListView: UIView {
    
    private let colors = Flavor.shared.colors
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        
        return stackview
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.startAnimating()
        
        return loadingView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
//        tableView.register(JourneyListCell.self, forCellReuseIdentifier: JourneyListCell.identifier)
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EventsListView {
    
    func setup() {
        backgroundColor = colors.background.color
        setupHierarchy()
        setupConstraints()
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
}
