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
    func setRemoteImage(urlString: String, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        guard let imageURL = URL(string: urlString) else {
            onError()
            return
        }
        
        kf.indicatorType = .activity
        kf.setImage(
            with: imageURL,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage,
            ],
            progressBlock: nil
        )
        { result in
            switch result {
            case .success(_):
                onSuccess()
            case .failure(_):
                onError()
            }
        }
    }
}
