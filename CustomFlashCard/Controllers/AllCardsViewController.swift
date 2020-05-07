//
//  AllCardsViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 21/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import RealmSwift
class AllCardsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCardsCollectionView: UICollectionView!
    var cards: Results<Card>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
        allCardsCollectionView.register(UINib.init(nibName: "AllCardsCell", bundle: nil), forCellWithReuseIdentifier: "AllCardsCell")
        allCardsCollectionView.reloadData()
        self.allCardsCollectionView.delegate = self
        self.allCardsCollectionView.dataSource = self
        allCardsCollectionView.allowsSelection = true
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false

    }
}
extension AllCardsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                 "AllCardsCell", for: indexPath) as! AllCardsCell
        cell.lbWord.text = cards?[indexPath.row].word ?? "No cards yet"
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print("selected")


    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.view.frame.width/3)-10, height: (self.view.frame.width/3)-10)
    }


    
    func loadCards() {
        cards = realm.objects(Card.self)
        allCardsCollectionView.reloadData()
    }
}
