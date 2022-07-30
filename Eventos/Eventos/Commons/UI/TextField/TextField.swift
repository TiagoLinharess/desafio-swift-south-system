//
//  TextField.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import UIKit

final class TextField: UITextField {
    
    private let textPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    private let style: Style
    private let type: FieldType
    private let name: String
    
    init(type: FieldType, name: String? = nil, placeholder: String, style: Style) {
        self.style = style
        self.type = type
        self.name = name ?? placeholder
        super.init(frame: .zero)
        setup(placeholder: placeholder)
        configureField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    private func setup(placeholder: String) {
        let quickSandRegular = Flavor.shared.fonts.quickSandRegular.withSize(16)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: style.onColor.withAlphaComponent(0.6),
            .font: quickSandRegular,
        ]
        
        textColor = style.onColor
        backgroundColor = style.color
        border(with: style.onColor, andWidth: 1)
        roundedCorner(withRadius: 8)
        font = quickSandRegular
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    private func configureField() {
        autocapitalizationType = type.autocapitalizationType
        keyboardType = type.keyboardType
    }
    
    func validate() throws {
        let validator = type.validator
        
        do {
            try validator.validate(text: text ?? "", fieldName: name)
        } catch let error {
            guard let error = error as? TextFieldError else { return }
            throw error
        }
    }
}
