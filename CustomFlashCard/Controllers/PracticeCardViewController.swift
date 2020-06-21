//
//  PracticeCardViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PracticeCaredViewController: UIViewController{
    
    var selectedCategory: Category?
    
    var cards: Results<Card>?
    let realm = try! Realm()
    var stackContainer : StackContainerView!
    var lblNodata: UILabel?
    
    //MARK: - Init
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = StackContainerView()
        let rect = CGRect(x: 50, y: 100, width: 300, height: 40)
        lblNodata = UILabel(frame: rect)
        view.addSubview(stackContainer)
        view.addSubview(lblNodata!)
        lblNodata!.text = "There is not card saved currently"
        lblNodata?.textColor = UIColor(named: "PupleCustom")
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Tracker"
        loadCards()
        stackContainer.dataSource = self as SwipeCardsDataSource
        
        if cards?.count == 0 {
            stackContainer.isHidden = true
            lblNodata!.isHidden = false
        }else{
            stackContainer.isHidden = false
            lblNodata!.isHidden = true
        }
    }
    //MARK: - Configurations
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        stackContainer.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        stackContainer.reloadData()
    }
    
}

extension PracticeCaredViewController : SwipeCardsDataSource {
    
    func numberOfCardsToShow() -> Int {
        return cards?.count ?? 1
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = cards?[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    func loadCards() {
        cards = selectedCategory?.cards.sorted(byKeyPath: "word", ascending: true)
    }
}
