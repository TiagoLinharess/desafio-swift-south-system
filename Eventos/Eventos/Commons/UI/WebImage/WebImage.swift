//
//  WebImage.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setRemoteImage(url: URL?, placeholder: String? = nil) {
        guard let imageURL = url else { return }
        
        kf.indicatorType = .activity
        kf.setImage(with:
            imageURL,
            placeholder: UIImage(named: placeholder ?? ""),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage,
            ])
    }
}
