//
//  CardViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 07/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
class CardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    var card :Card?
    let realm = try! Realm()
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var tfWord: UITextField!
    @IBOutlet weak var tfMeaning: UITextField!
    
    @IBOutlet weak var tfCategory: UITextField!
    
    @IBOutlet weak var tvComment: UITextView!
    
    @IBOutlet weak var btnSave: UIButton!
    let thePicker = UIPickerView()
       var cardArray: [Data] = []
       var categories: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDelete.layer.cornerRadius = 5
        btnDelete.isHidden = false
        btnSave.isHidden = true
        tfWord.isEnabled = false
        tfMeaning.isEnabled = false
        tfCategory.isEnabled = false
        tvComment.isEditable = false
        loadCategories()
        tfWord.text = card?.word
        tfMeaning.text = card?.meaning
        tvComment.text = card?.sentence
        tfCategory.text = realm.objects(Category.self).filter(" cards.word = %@", card!.word!).first?.title
        tfCategory.inputView = thePicker
               thePicker.delegate = self
               thePicker.dataSource = self
    }
    
 
    @IBAction func pressedEdit(_ sender: Any) {
        btnDelete.isHidden = true
        btnSave.isHidden = false
        tfWord.isEnabled = true
        tfMeaning.isEnabled = true
        tfCategory.isEnabled = true
        tvComment.isEditable = true
    }
    @IBAction func pressedDelete(_ sender: Any) {
        if let acard = card {
            do {
                try realm.write{
                    realm.delete(acard)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
        tfWord.text = ""
        tfMeaning.text = ""
        tfCategory.text = ""
        tvComment.text = ""
        let alert = UIAlertController(title: "Delete", message: "Your card has been deleted", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressedSave(_ sender: Any) {
        if isValid(){
            if let acard = card {
                do {
                    try realm.write{
                        acard.word = tfWord.text
                        acard.meaning = tfMeaning.text
                        acard.sentence = tvComment.text
                    }
                    let alert = UIAlertController(title: "Edit", message: "Your card has been Edit", preferredStyle: .alert)
                           let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alert.addAction(action)
                           present(alert, animated: true, completion: nil)
                    btnDelete.isHidden = false
                           btnSave.isHidden = true
                           tfWord.isEnabled = false
                           tfMeaning.isEnabled = false
                           tfCategory.isEnabled = false
                           tvComment.isEditable = false
                    
                } catch {
                    print("Error Saving item, \(error)")
                }
            }
        }
    }
    
    @IBAction func pressedBackbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
     }
    func loadCategories() {
           categories = realm.objects(Category.self)
       }
    //MARK: TextField Validation
    func isValid() ->Bool{
        var flag = true
        if tfWord.text!.isEmpty {
            flag = false
        }
        if tfMeaning.text!.isEmpty {
            flag = false
        }
        return flag
    }
}
