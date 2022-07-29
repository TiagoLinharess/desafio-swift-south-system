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
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        stackView.spacing = 16
        stackView.backgroundColor = colors.surface.color
        stackView.roundedCorner(withRadius: 8)
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = colors.surface.onColor
        label.font = fonts.quickSandRegular.withSize(16)
        
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
    }
}

extension EventsListTableViewCell: ViewCode {
    
    func setupHierarchy() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
    }
    
    func setupConstraints() {
        contentView.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
