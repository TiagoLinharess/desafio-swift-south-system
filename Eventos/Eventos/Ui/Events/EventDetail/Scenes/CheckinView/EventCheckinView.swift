//
//  EventCheckinView.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Combine
import UIKit

final class EventCheckinView: UIView {
    
    private let viewModel: EventCheckinViewModelProtocol
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    private var cancellables = Set<AnyCancellable>()
    
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
        TextField(type: .email, name: "E-mail", placeholder: "E-mail", style: .background)
    }()
    
    private lazy var nameTextField: TextField = {
        TextField(type: .notEmpty, placeholder: "Nome", style: .background)
    }()
    
    private lazy var checkinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fazer Check-in", for: .normal)
        button.setTitleColor(colors.primary.onColor, for: .normal)
        button.titleLabel?.font = fonts.quickSandBold.withSize(20)
        button.backgroundColor = colors.primary.color
        button.roundedCorner(withRadius: 8)
        button.addTarget(nil, action: #selector(checkinButtonDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var checkinLoading: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.startAnimating()
        loadingView.color = colors.primary.onColor
        loadingView.backgroundColor = colors.primary.color
        loadingView.roundedCorner(withRadius: 8)
        loadingView.isHidden = true
        
        return loadingView
    }()
    
    init(viewModel: EventCheckinViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func checkinButtonDidTapped(_ sender: Any) {
        guard let emailText = emailTextField.text, let nameText = nameTextField.text else { return }
        
        do {
            try emailTextField.validate()
            try nameTextField.validate()
            viewModel.makeCheckin(email: emailText, name: nameText)
        } catch {
            guard let error = error as? TextFieldError else { return }
            presentToast(with: error.message)
        }
    }
}

extension EventCheckinView: ViewCode {
    
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(checkinLabel)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(checkinButton)
        containerStackView.addArrangedSubview(checkinLoading)
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
            
            nameTextField.widthAnchor.constraint(equalToConstant: width),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            checkinButton.widthAnchor.constraint(equalToConstant: width),
            checkinButton.heightAnchor.constraint(equalToConstant: 44),
            
            checkinLoading.widthAnchor.constraint(equalToConstant: width),
            checkinLoading.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}

private extension EventCheckinView {
    
    func setupBinding() {
        viewModel.checkinStatusPublisher
            .debounce(for: 0, scheduler: DispatchQueue.main)
            .sink { [weak self] viewStatus in
            self?.handle(with: viewStatus)
        }.store(in: &cancellables)
    }
    
    func handle(with viewStatus: ViewStatus) {
        resetCheckin()
        
        switch viewStatus {
        case .loading:
            presentCheckinLoading()
        case let .error(error):
           presentToast(with: error)
        case .success:
            presentToast(with: "Checkin efetuado com sucesso.")
        default:
            break
        }
    }
    
    func resetCheckin() {
        checkinButton.isHidden = false
        checkinLoading.isHidden = true
    }
    
    func presentCheckinLoading() {
        checkinButton.isHidden = true
        checkinLoading.isHidden = false
    }
    
    func presentToast(with message: String) {
        let toast = UIToast(text: message)
        toast.present()
    }
}
