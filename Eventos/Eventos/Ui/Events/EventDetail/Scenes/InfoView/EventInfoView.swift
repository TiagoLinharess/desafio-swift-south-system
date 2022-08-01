//
//  EventInfoView.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import UIKit

final class EventInfoView: UIView {
    
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    private let viewModel: EventInfoViewModelProtocol
    
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
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandBold.withSize(26)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandRegular.withSize(14)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandMedium.withSize(16)
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandMedium.withSize(16)
        
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(colors.primary.onColor, renderingMode: .alwaysOriginal)
        button.setTitle("Compartilhar", for: .normal)
        button.setTitleColor(colors.primary.onColor, for: .normal)
        button.titleLabel?.font = fonts.quickSandBold.withSize(20)
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = colors.primary.color
        button.roundedCorner(withRadius: 8)
        button.addTarget(nil, action: #selector(shareButtonDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    init(viewModel: EventInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func shareButtonDidTapped(_ sender: Any) {
        viewModel.share()
    }
}

extension EventInfoView: ViewCode {
    
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(eventImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(priceLabel)
        containerStackView.addArrangedSubview(shareButton)
    }
    
    func setupConstraints() {
        let width = UIScreen.main.bounds.width - 32
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.widthAnchor.constraint(equalToConstant: width),
            
            eventImageView.widthAnchor.constraint(equalToConstant: width),
            eventImageView.heightAnchor.constraint(equalToConstant: 220),
            
            shareButton.widthAnchor.constraint(equalToConstant: width),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}

private extension EventInfoView {
    
    func configure() {
        titleLabel.text = viewModel.event.title
        dateLabel.text = viewModel.event.date.timeStampToDateFormat()
        descriptionLabel.text = viewModel.event.description
        priceLabel.text = "Valor da inscrição: R$\(viewModel.event.price)"
            .replacingOccurrences(of: ".", with: ",")
        configure(viewModel.event.image)
    }
    
    func configure(_ photo: String) {
        eventImageView.setRemoteImage(urlString: photo) {
            self.eventImageView.roundedCorner(withRadius: 24)
            self.eventImageView.contentMode = .scaleAspectFill
        } onError: {
            self.eventImageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
            self.eventImageView.tintColor = self.colors.background.onColor
            self.eventImageView.roundedCorner(withRadius: 0)
            self.eventImageView.contentMode = .scaleAspectFit
        }
    }
}
