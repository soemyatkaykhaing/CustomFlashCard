//
//  CardFormViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 13/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
class CardFormViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
   // MARK: Variables
    @IBOutlet weak var tfWord: UITextField!
    @IBOutlet weak var tfMeaning: UITextField!
    @IBOutlet weak var tfCategory: UITextField!
    @IBOutlet weak var tvSentence: UITextView!
    @IBOutlet weak var imgWord: UIImageView!
    let thePicker = UIPickerView()
    var cardArray: [Data] = []
    var categories: Results<Category>?
    var selectedCategory: Category?
    lazy var realm:Realm = {
        return try! Realm()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tfCategory.inputView = thePicker
        thePicker.delegate = self
        thePicker.dataSource = self
    }
    //MARK: IB Actions
    @IBAction func savePressed(_ sender: Any) {
        let newCard = Card()
        newCard.date = Date()
        newCard.word = tfWord.text
        newCard.meaning = tfMeaning.text
        newCard.sentence = tvSentence.text
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainView") as CreateViewController
       print(vc)
        self.save(card: newCard)
        let alert = UIAlertController(title: "New Card", message: "A New Card is added", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (clear) in
//            self.tfWord.text = ""
//            self.tfCategory.text = ""
//            self.tfMeaning.text = ""
//            self.tvSentence.text = ""
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        vc.acard = newCard
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil,userInfo: ["object":newCard])
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Functions
    func validateForm()-> Bool{
        var flag = true
        if tfWord.text!.isEmpty {
            flag = false
        }
        if tfMeaning.text!.isEmpty {
            flag = false
        }
        return flag
    }
    //MARK: PickerView Delegate DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories?.count ?? 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categories![row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfCategory.text = categories![row].title
        selectedCategory = categories![row]
    }
    //MARK: Utilities functions
    func save(card: Card) {
        if let currentCategory = self.selectedCategory {
                       do {
                           try self.realm.write {
                               let card = Card()
                            card.word = tfWord.text!
                            card.meaning = tfMeaning.text!
                            card.date = Date()
                            currentCategory.cards.append(card)
                           }
                       } catch {
                           print("Error saving new items, \(error)")
                       }
        }
    }
    func loadCategories() {
        categories = realm.objects(Category.self)
    }
}
