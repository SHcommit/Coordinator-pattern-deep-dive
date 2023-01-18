//
//  KanjiDetailCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

class KanjiDetailCoordinator {
    private var presenter: UINavigationController
    private var kanjiList: [Kanji]
    private var kanji: Kanji
    private var kanjiDetailVC: KanjiDetailVC?
    private var wordKanjiListVC: KanjiListVC?
    private var allKanjiCoordinator: AllKanjiListCoordinator?
    
    init(presenter: UINavigationController, kanjiList: [Kanji], kanji: Kanji, kanjiDetailVC: KanjiDetailVC? = nil, wordKanjiListVC: KanjiListVC? = nil) {
        self.presenter = presenter
        self.kanjiList = kanjiList
        self.kanji = kanji
    }
    
}

extension KanjiDetailCoordinator: Coordinator {
    func start() {
        let kanjiDetailViewController = KanjiDetailVC(nibName: nil, bundle: nil)
        kanjiDetailViewController.title = kanji.name
        self.kanjiDetailVC = kanjiDetailViewController
        kanjiDetailVC?.kanjiDetailDelegate = self
        presenter.pushViewController(kanjiDetailViewController, animated: true)
    }
}

extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
    func kanjiDetailViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        let kanjiDetailListViewController = KanjiListVC(nibName: nil, bundle: nil)
        kanjiDetailListViewController.kanjiList = kanjiList
        presenter.pushViewController(kanjiDetailListViewController, animated: true)
    }
    
}
