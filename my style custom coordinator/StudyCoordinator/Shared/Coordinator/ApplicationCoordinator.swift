//
//  ApplicationCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit



// main coordinator
class ApplicationCoordinator: NSObject {
    let window: UIWindow
    var parent: Coordinator? = nil
    private var _childrenCoordinator: [Coordinator] = []
    private var rootViewController: UINavigationController
    //let allKanjiListCoordinator: AllKanjiListCoordinator
    
    init(window: UIWindow) { //4
        // 여기서 컨테이너뷰 지정. 
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.backgroundColor = .green
        //초기 시작화면을 뭐로할것인가? 난 추후. 사용자가 로그인했는지 영구저장소에 값이 있으면 메인 else 로그인.
     }
}

extension ApplicationCoordinator: Coordinator {
    
    var children: [Coordinator] {
        get {
            return _childrenCoordinator
        }
        set {
            _childrenCoordinator = newValue
        }
    }
    
    var presenter: UINavigationController {
        get {
            return rootViewController
        }
        set {
            rootViewController = newValue
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
        rootViewController.delegate = self
        window.makeKeyAndVisible()
        kanjiListSubscription()
    }
    
    func finish() {
        removeChildren()
    }
    
}

extension ApplicationCoordinator {
    
    func kanjiListSubscription() {
        let allKanjiListCoordinator = AllKanjiListCoordinator(
            presenter: rootViewController,
            allKanjiList: [Kanji(name: "hi"),
                           Kanji(name: "haha"),
                           Kanji(name: "hoho")])
        ConfigCoordinator.setupChild(detail: allKanjiListCoordinator) {
            $0.parent = self
            self.addChild(coordinator: $0)
            $0.start()
        }
    }
}

extension ApplicationCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("start:-------")
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            print("none")
            return
        }
        print("start1")
        if navigationController.viewControllers.contains(fromVC) {
            print("DEBUG: Running \(fromVC)")
            return
        }
        switch fromVC {
        case is KanjiListVC:
            popKanjiListCoordinator(fromVC)
            break
        case is KanjiDetailVC:
            popKanjiDetailCoordinator(fromVC)
            break
        default:
            print("DEBUG: Unexpected VC :\(fromVC)")
        }
    }
}

//MARK: - UINavigationControllerDelegate Helpers
extension ApplicationCoordinator {
    func popKanjiListCoordinator(_ fromVC: UIViewController) {
        print("DEBUG: KanjiListVC pop")
        guard let kanjiListVC = fromVC as? KanjiListVC else {
            return
        }
        print("---")
        print("start2 :\(String(describing: kanjiListVC.coordinator?.parent?.children.count))")
        print("---")
        guard let coord = kanjiListVC.coordinator else {
            print("no")
            return
        }
        kanjiListVC.coordinator?.parent?.removeChild(coordinator: coord)
        kanjiListVC.coordinator?.removeChildren()
        print("---")
        print("start2 :\(String(describing: kanjiListVC.coordinator?.parent?.children.count))")
    }
    
    func popKanjiDetailCoordinator(_ fromVC: UIViewController) {
        print("DEBUG: kanjiDetailVC pop")
        guard let kanjiDetailVC = fromVC as? KanjiDetailVC else {
            return
        }
        print("start3 :\(String(describing: kanjiDetailVC.coordinator?.parent?.children.count))")
        print("start3 :\(String(describing: kanjiDetailVC.coordinator?.children.count))")
        print("---")
        guard let coord = kanjiDetailVC.coordinator else {
            print("no3")
            return
        }
        kanjiDetailVC.coordinator?.parent?.removeChild(coordinator: coord)
        kanjiDetailVC.coordinator?.removeChildren()
        print("start3 :\(String(describing: kanjiDetailVC.coordinator?.parent?.children.count))")
        print("start3 :\(String(describing: kanjiDetailVC.coordinator?.children.count))")
    }
}
