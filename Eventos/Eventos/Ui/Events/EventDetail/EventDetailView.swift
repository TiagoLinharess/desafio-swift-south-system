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
    private let fonts = Flavor.shared.fonts
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .top
        stackview.distribution = .fill
        stackview.spacing = 24
        
        return stackview
    }()
    
    private lazy var eventInfoView: EventInfoView = {
        EventInfoView(viewModel: EventInfoViewModel(event: viewModel.event))
    }()
    
    private lazy var eventCheckinView: EventCheckinView = {
        EventCheckinView(viewModel: EventCheckinViewModel(event: viewModel.event))
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
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(eventInfoView)
        containerStackView.addArrangedSubview(eventCheckinView)
    }
    
    func setupConstraints() {
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        scrollView.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }
    
    func configureView() {
        backgroundColor = colors.background.color
    }
}

extension EventDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
