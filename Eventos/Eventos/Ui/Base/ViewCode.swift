//
//  ViewCode.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

protocol ViewCode: UIView {
    func setup()
    func setupHierarchy()
    func setupConstraints()
    func configureView()
}

extension ViewCode {
    
    func setup() {
        setupHierarchy()
        setupConstraints()
        configureView()
    }
}
