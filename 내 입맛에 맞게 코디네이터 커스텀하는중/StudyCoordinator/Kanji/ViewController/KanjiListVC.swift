//
//  KanjiListViewController.swift
//  StudyCoordinator
//
//  Created by 양승현 on 2023/01/18.
//

import UIKit

struct Kanji {
    var name: String
}

protocol KanjiListViewControllerDelegate: AnyObject {
  func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji)
}

class KanjiListVC: UITableViewController {
    
    var kanjiList: [Kanji]!
    weak var kanjiListVCDelegate: KanjiListViewControllerDelegate?
    weak var coordinator: AllKanjiListCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //서브 칠드런이 많아지면 혼란스러워짐
    //이렇게 일일이 dismiss할 때 취소하는게 아니라 UINavigationController를 이용하는게 편함.
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        coordinator?.finish()
//    }


}

extension KanjiListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjiList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Acell")
        cell.textLabel?.text = kanjiList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        kanjiListVCDelegate?.kanjiListViewControllerDidSelectKanji(kanjiList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
