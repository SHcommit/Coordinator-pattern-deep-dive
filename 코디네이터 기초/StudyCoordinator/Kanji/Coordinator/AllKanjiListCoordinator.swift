//
//  AllKanjiListCoordinator.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

class AllKanjiListCoordinator{
    
    private let presenter: UINavigationController
    private let allKanjiList: [Kanji]
    private var kanjiListViewController: KanjiListVC?
    
    private var kanjiDetailCoordinator: KanjiDetailCoordinator?
    
    init(presenter: UINavigationController, allKanjiList: [Kanji]) {
        self.presenter = presenter
        self.allKanjiList = allKanjiList
    }
}

extension AllKanjiListCoordinator: Coordinator {
    func start() {
        let kanjiListViewController = KanjiListVC(nibName: nil, bundle: nil)
        kanjiListViewController.title = "Kanji list"
        kanjiListViewController.view.backgroundColor = .systemRed
        kanjiListViewController.kanjiList = allKanjiList
        kanjiListViewController.kanjiListVCDelegate = self
        presenter.pushViewController(kanjiListViewController, animated: true)
        self.kanjiListViewController = kanjiListViewController
    }
    
}

extension AllKanjiListCoordinator: KanjiListViewControllerDelegate {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        kanjiDetailCoordinator = KanjiDetailCoordinator(
            presenter: presenter,
            kanjiList: allKanjiList,
            kanji: selectedKanji)
        kanjiDetailCoordinator?.start()
    }
}
