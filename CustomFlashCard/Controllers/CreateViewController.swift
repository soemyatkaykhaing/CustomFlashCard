//
//  CreateViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 12/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import RealmSwift
import DJSemiModalViewController

class CreateViewController: UIViewController {
    //MARK: Vars
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var cardTap: UITapGestureRecognizer!
    
    @IBOutlet weak var lblWordInCard: UILabel!
    @IBOutlet weak var btnCreateCard: UIButton!
    let realm = try! Realm()
    var acard : Card?
    var charArray: [String]?
    var groupName: String?
    var tfGroup: UITextField!
    var tvDesc: UITextView!
    override func viewDidLoad() {
        cardTap.addTarget(self, action: #selector(tapped(_:)))
        super.viewDidLoad()
        cardView.isHidden = true
        cardView.layer.shadowColor = UIColor(named: "PupleCustom")?.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowOpacity = 0.8
        cardView.layer.shadowRadius = 4.0
        cardView.layer.cornerRadius = 15
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let cardA = notification.userInfo?["object"] as? Card {
            acard = cardA
            cardView.isHidden = false
            lblWordInCard.text = cardA.word
        }
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        
        UIView.transition(with: cardView, duration: 0.7, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
        if lblWordInCard.text == acard?.word {
            lblWordInCard.text = acard?.meaning
        }else{
            lblWordInCard.text = acard?.word
        }
        
    }
    @IBAction func addSubjectPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddCategory", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddCategory") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func addCardPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddCard", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddCard") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
    
   
}
