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
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandBold.withSize(26)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandMedium.withSize(16)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandRegular.withSize(14)
        
        return label
    }()
    
    init(viewModel: EventDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
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
        containerStackView.addArrangedSubview(eventImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        let width = UIScreen.main.bounds.width - 32
        
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
            
            titleLabel.widthAnchor.constraint(equalToConstant: width),
            descriptionLabel.widthAnchor.constraint(equalToConstant: width),
            dateLabel.widthAnchor.constraint(equalToConstant: width),
            
            eventImageView.widthAnchor.constraint(equalToConstant: width),
            eventImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureView() {
        backgroundColor = colors.background.color
    }
}

private extension EventDetailView {
    
    func configure() {
        titleLabel.text = viewModel.event.title
        dateLabel.text = viewModel.event.date.timeStampToDateFormat()
        descriptionLabel.text = viewModel.event.description
        configure(viewModel.event.image)
    }
    
    func configure(_ photo: String) {
        eventImageView.setRemoteImage(urlString: photo) {
            self.eventImageView.roundedCorner(withRadius: 24)
            self.eventImageView.contentMode = .scaleAspectFill
        } onError: {
            self.eventImageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
            self.eventImageView.tintColor = self.colors.surface.onColor
            self.eventImageView.roundedCorner(withRadius: 0)
            self.eventImageView.contentMode = .scaleAspectFit
        }
    }
}


extension EventDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
