//
//  AllKanjiListCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

class AllKanjiListCoordinator{
    
    private var _presenter: UINavigationController
    internal weak var parent: ApplicationCoordinator?
    internal weak var detailParent: KanjiDetailCoordinator?
    private var _children: [Coordinator] = []
    private var allKanjiList: [Kanji]
    private var kanjiDetailCoordinator: KanjiDetailCoordinator?
    
    init(presenter: UINavigationController, allKanjiList: [Kanji]) {
        _presenter = presenter
        self.allKanjiList = allKanjiList
    }
}

extension AllKanjiListCoordinator: Coordinator{
    
    var children: [Coordinator] {
        get {
            return _children
        }
        set {
            _children = newValue
        }
    }
    
    var presenter: UINavigationController {
        get {
            return _presenter
        }
        set {
            _presenter = newValue
        }
    }
}

extension AllKanjiListCoordinator {
    
    func start() {
        let kanjiListViewController = KanjiListVC(nibName: nil, bundle: nil)
        ConfigCoordinator.setupVC(detail: kanjiListViewController) {
            $0.title = "Kanji list"
            $0.view.backgroundColor = .systemPink
            $0.kanjiList = self.allKanjiList
            $0.kanjiListVCDelegate = self
            $0.coordinator = self
        }
        presenter.pushViewController(kanjiListViewController, animated: true)
    }
    
    func finish() {
        parent?.removeChild(coordinator: self)
        removeChildren()
    }
    
}

extension AllKanjiListCoordinator: KanjiListViewControllerDelegate {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        kanjiDetailSubscription(selectedKanji)
    }
}


extension AllKanjiListCoordinator {
    
    func kanjiDetailSubscription(_ selectedKanji: Kanji) {
        let kanjiDetail = KanjiDetailCoordinator(presenter: presenter,
                                                 kanjiList: [Kanji(name: "hssssi"),
                                                             Kanji(name: "hasssha"),
                                                             Kanji(name: "hosssho")],
                                                 kanji: selectedKanji)
        
        ConfigCoordinator.setupChild(detail: kanjiDetail) {
            $0.parent = self
            self.addChild(coordinator: $0)
            print(self.children.count)
            $0.start()
        }
    }
}
