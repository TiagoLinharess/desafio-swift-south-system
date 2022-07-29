//
//  Coordinator.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var onFinish: ((Coordinator) -> Void)? { get }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get }
    
    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator where Self: UINavigationControllerDelegate {
    
    func childDidFinish(_ child: Coordinator?) {
        navigationController?.delegate = self
        childCoordinators.removeAll {
            $0 === child
        }
    }
}
