//
//  EventCheckinView.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import UIKit

final class EventCheckinView: UIView {
    
    private let viewModel: EventCheckinViewModelProtocol
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .top
        stackview.distribution = .fill
        stackview.spacing = 16
        stackview.roundedCorner(withRadius: 16)
        stackview.border(with: colors.background.onColor, andWidth: 4)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return stackview
    }()
    
    private lazy var checkinLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = colors.background.onColor
        label.font = fonts.quickSandBold.withSize(26)
        label.text = "Check-in:"
        
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let font = fonts.quickSandRegular.withSize(16)
        let color = colors.background.onColor
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.withAlphaComponent(0.6),
            .font: font,
        ]
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.border(with: color, andWidth: 1)
        textField.roundedCorner(withRadius: 8)
        textField.font = font
        textField.textColor = color
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: attributes)
        
        return textField
    }()
    
    init(viewModel: EventCheckinViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCheckinView: ViewCode {
    
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(checkinLabel)
        containerStackView.addArrangedSubview(emailTextField)
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
            
            emailTextField.widthAnchor.constraint(equalToConstant: width),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}
