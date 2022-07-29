//
//  CustomErrorView.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

final class CustomErrorView: UIView {
    
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    private var action: (() -> Void)?
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .center
        stackview.spacing = 32
        
        return stackview
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.triangle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = colors.background.onColor
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandMedium.withSize(20)
        
        return label
    }()
    
    private lazy var buttonView: UIButton = {
        let button = UIButton()
        button.setTitle("Tentar novamente", for: .normal)
        button.setTitleColor(colors.primary.onColor, for: .normal)
        button.titleLabel?.font = fonts.quickSandMedium.withSize(20)
        button.backgroundColor = colors.primary.color
        button.roundedCorner(withRadius: 8)
        button.addTarget(nil, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func actionButtonTapped(_ sender: Any) {
        action?()
    }
    
    func configure(with text: String, action: @escaping () -> Void) {
        titleLabel.text = text
        self.action = action
    }
}

extension CustomErrorView: ViewCode {
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(buttonView)
    }
    
    func setupConstraints() {
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            buttonView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 64),
            buttonView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func configureView() {
        backgroundColor = colors.background.color
    }
}
