//
//  KanjiDetailCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

class KanjiDetailCoordinator {
    internal var presenter: UINavigationController
    private var kanjiList: [Kanji]
    private var kanji: Kanji
    internal var parent: AllKanjiListCoordinator?
    private var _children: [Coordinator] = []

    
    init(presenter: UINavigationController, kanjiList: [Kanji], kanji: Kanji, kanjiDetailVC: KanjiDetailVC? = nil, wordKanjiListVC: KanjiListVC? = nil) {
        self.presenter = presenter
        self.kanjiList = kanjiList
        self.kanji = kanji
    }
    
}

//MARK: - Coordinator
extension KanjiDetailCoordinator: Coordinator {
    
    var children: [Coordinator] {
        get {
            return _children
        }
        set {
            _children = newValue
        }
    }
    
    func start() {
        let kanjiDetailViewController = KanjiDetailVC(nibName: nil, bundle: nil)
        ConfigCoordinator.setupVC(detail: kanjiDetailViewController) {
            $0.title = self.kanji.name
            $0.kanjiDetailDelegate = self
            $0.coordinator = self
        }
        presenter.pushViewController(kanjiDetailViewController, animated: true)
    }
    
    func finish() {
        parent?.removeChild(coordinator: self)
        removeChildren()
    }
    
}

extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
    func kanjiDetailViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        kanjiListSubscription(kanji)
    }
    
}

extension KanjiDetailCoordinator {
    func kanjiListSubscription(_ selectedKanji: Kanji) {
        let allKanji = AllKanjiListCoordinator(presenter: presenter,
                                               allKanjiList: kanjiList)
        ConfigCoordinator.setupChild(detail: allKanji) {
            $0.detailParent = self
            self.addChild(coordinator: $0)
            print(self.children.count)
            $0.start()
        }
    }
}
