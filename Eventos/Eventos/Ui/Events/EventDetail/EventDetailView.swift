//
//  EventDetailView.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

final class EventDetailView: UIView {
    
    private let viewModel: EventDetailViewModelProtocol
    private let colors = Flavor.shared.colors
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .red
        
        return scrollView
    }()
    
    init(viewModel: EventDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventDetailView: ViewCode {
    
    func setupHierarchy() {
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        scrollView.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureView() {
        backgroundColor = colors.background.color
    }
}
