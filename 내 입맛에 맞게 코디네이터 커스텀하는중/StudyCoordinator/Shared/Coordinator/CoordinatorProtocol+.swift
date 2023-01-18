//
//  Coordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

protocol Coordinator: AnyObject{
    var children: [Coordinator] { get set }
    var presenter: UINavigationController { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    
    func addChild(coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func removeChild(coordinator: Coordinator) {
        guard let idx = children.firstIndex(where: {$0===coordinator}) else {
            print("DEBUG: Couldn't find target: \(coordinator) in childCoordinators")
            return
        }
        children.remove(at: idx)
    }
    
    func removeChildren() {
        children.removeAll()
    }
    
    // 추가로 나중에 삭제할 떄 부모꺼에서 자식 삭제하는거 그거 너무길어서 함수로 바꿔보러야겠음
}



struct ConfigCoordinator {
    
    static func setupChild<T>(detail target : T, apply: @escaping (T)->Void) where T: Coordinator {
        apply(target)
    }
    
    static func setupVC<T>(detail target: T, apply: @escaping (T)->Void) where T: UIViewController {
        apply(target)
    }
    
}
