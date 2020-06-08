//
//  AllCardsViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 21/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import RealmSwift
class AllCardsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var allCardsCollectionView: UICollectionView!
    
    @IBOutlet weak var cardSearchBar: UISearchBar!
    var cards: Results<Card>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
        allCardsCollectionView.register(UINib.init(nibName: "WordCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WordCardCell")
        allCardsCollectionView.reloadData()
        self.allCardsCollectionView.delegate = self
        self.allCardsCollectionView.dataSource = self
        allCardsCollectionView.allowsSelection = true
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        cardSearchBar.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        loadCards()
    }
}
extension AllCardsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                 "WordCardCell", for: indexPath) as! WordCardCollectionViewCell
        cell.lbWord.text = cards?[indexPath.row].word ?? "No cards yet"
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let storyboard = UIStoryboard(name: "CardView", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "CardView") as! UINavigationController
        let vc1 = vc.topViewController as! CardViewController
        vc1.card = cards?[indexPath.row]
          self.present(vc, animated: true, completion: nil)


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
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           cards = cards?.filter("word CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "word", ascending: true)
           allCardsCollectionView.reloadData()
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchBar.text?.count == 0 {
               loadCards()
               DispatchQueue.main.async {
                   searchBar.resignFirstResponder()
               }
           }
       }
}
