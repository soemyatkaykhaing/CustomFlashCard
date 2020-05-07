//
//  AddCategoryViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import RealmSwift
class AddCategoryViewController: UIViewController {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCategoryPressed(_ sender: Any) {
        let newCategory = Category()
        newCategory.date = Date()
        newCategory.title = tfTitle.text
        newCategory.desc = tvDescription.text
        self.save(category: newCategory)
        let alert = UIAlertController(title: "New Cateogry", message: "A New Category is added", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    func save(category: Category) {
           do {
               try realm.write {
                 realm.add(category)
               }
           } catch {
               print("Error saving new items, \(error)")
           }
    }
}
