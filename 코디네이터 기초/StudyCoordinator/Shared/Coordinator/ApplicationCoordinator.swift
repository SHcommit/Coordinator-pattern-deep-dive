//
//  ApplicationCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let allKanjiListCoordinator: AllKanjiListCoordinator
    
    init(window: UIWindow) { //4
        // 여기서 컨테이너뷰 지정. 
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.backgroundColor = .green
        //초기 시작화면을 뭐로할것인가? 난 추후. 사용자가 로그인했는지 영구저장소에 값이 있으면 메인 else 로그인.
        
        allKanjiListCoordinator = AllKanjiListCoordinator(
            presenter: rootViewController,
            allKanjiList: [Kanji(name: "hi"),
                           Kanji(name: "haha"),
                           Kanji(name: "hoho")])
     }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        allKanjiListCoordinator.start()
    }
}
