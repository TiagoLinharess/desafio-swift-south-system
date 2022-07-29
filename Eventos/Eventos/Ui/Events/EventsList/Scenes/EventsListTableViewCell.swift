//
//  EventsListTableViewCell.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

class EventsListTableViewCell: UITableViewCell {
    
    static let identifier = "EventsListTableViewCell"
    
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.spacing = 16
        stackView.backgroundColor = colors.surface.color
        stackView.roundedCorner(withRadius: 24)
        
        return stackView
    }()
    
    private lazy var titleAndDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandMedium.withSize(20)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandRegular.withSize(12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ event: EventViewData) {
        titleLabel.text = event.title
        configure(event.image)
        configure(event.date)
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
    
    func configure(_ dateInt: Int) {
        dateLabel.text = dateInt.timeStampToDateFormat()
    }
}

extension EventsListTableViewCell: ViewCode {
    
    func setupHierarchy() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(eventImageView)
        containerStackView.addArrangedSubview(titleAndDateStackView)
        titleAndDateStackView.addArrangedSubview(titleLabel)
        titleAndDateStackView.addArrangedSubview(dateLabel)
    }
    
    func setupConstraints() {
        contentView.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            
            eventImageView.widthAnchor.constraint(equalToConstant: 80),
            eventImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
