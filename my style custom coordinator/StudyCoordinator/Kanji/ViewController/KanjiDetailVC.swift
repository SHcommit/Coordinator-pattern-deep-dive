//
//  KanjiDetailViewController.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

protocol KanjiDetailViewControllerDelegate: AnyObject {
  func kanjiDetailViewControllerDidSelectKanji(_ selectedKanji: Kanji)
}

class KanjiDetailVC: UITableViewController {
    
    var kanjiList: [Kanji] = [Kanji(name: "hsssi"),Kanji(name: "hasssha"),Kanji(name: "hohsssso")] 
    weak var kanjiDetailDelegate: KanjiDetailViewControllerDelegate?
    weak var coordinator: KanjiDetailCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension KanjiDetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjiList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Acell")
        cell.textLabel?.text = kanjiList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        kanjiDetailDelegate?.kanjiDetailViewControllerDidSelectKanji(kanjiList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

