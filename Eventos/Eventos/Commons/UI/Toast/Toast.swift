//
//  Toast.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import ToastViewSwift

class UIToastView: UIStackView {
    
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    
    public init(_ title: String) {
        super.init(frame: CGRect.zero)
        axis = .vertical
        alignment = .center
        distribution = .fillEqually
        backgroundColor = colors.primary.color
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = fonts.quickSandRegular.withSize(16)
        titleLabel.textColor = colors.primary.onColor
        titleLabel.numberOfLines = 1
        addArrangedSubview(titleLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIToast {
    
    private let toast: Toast
    private let colors = Flavor.shared.colors
    private let fonts = Flavor.shared.fonts
    
    init(text: String) {
        let config = ToastConfiguration(
            autoHide: true,
            enablePanToClose: true,
            displayTime: 5,
            animationTime: 0.2
        )
        
        self.toast = Toast.custom(
            view: AppleToastView(
                child: UIToastView(text),
                minHeight: 58,
                minWidth: 150,
                darkBackgroundColor: colors.primary.color,
                lightBackgroundColor: colors.primary.color
            ),
            config: config
        )
    }
    
    func present() {
        toast.show()
    }
}
