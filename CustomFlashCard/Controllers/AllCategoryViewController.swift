//
//  AllCategoryViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
class AllCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
        categoryCollectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.reloadData()
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false

    }
    override func viewDidAppear(_ animated: Bool) {
        loadCards()
    }
}
extension AllCategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                 "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.lbCategoryName.text = categories?[indexPath.row].title ?? "No Category yet"
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let storyboard = UIStoryboard(name: "PracticeCard", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "PracticeCard") as! UINavigationController
        let nextVC = vc.topViewController as! PracticeCaredViewController
        nextVC.selectedCategory = categories?[indexPath.row]
          self.present(vc, animated: true, completion: nil)


    }
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {

           return CGSize(width: (self.view.frame.width/3)-10, height: (self.view.frame.width/3)-10)
       }

    func loadCards() {
        categories = realm.objects(Category.self)
        categoryCollectionView.reloadData()
    }
}


