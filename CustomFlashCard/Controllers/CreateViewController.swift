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
    
    @IBOutlet weak var letterTableView: UITableView!
    var tableArray:[String: [String]] = ["Group" : [], "New Group": [], "Same Meaning": [],"New Same Meaning": []]
    var cards: Results<Card>?
    var newLetter : [Letter]?
    var oldLetter : [Letter]?
    var sameMeaning : [SameMeaning]?
    var sameMeanings : Results<SameMeaning>?
    var letters : Results<Letter>?
    let realm = try! Realm()
    var acard : Card?
    var charArray: [String]?
    var groupName: String?
    var tfGroup: UITextField!
    var tvDesc: UITextView!
    override func viewDidLoad() {
        cardTap.addTarget(self, action: #selector(tapped(_:)))
        super.viewDidLoad()
        let customNib = UINib(nibName: "TableViewCell", bundle: nil)
        letterTableView.register(customNib, forCellReuseIdentifier: "LetterCell")
        letterTableView.delegate = self
        letterTableView.dataSource = self
        letterTableView.reloadData()
        cardView.isHidden = true
        letterTableView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let cardA = notification.userInfo?["object"] as? Card {
            acard = cardA
            cardView.isHidden = false
            letterTableView.isHidden = false
            lblWordInCard.text = cardA.word
           // loadCards(acard: cardA)
            letterTableView.reloadData()
//            print(tableArray["New Same Meaning"])
//            tableArray["New Same Meaning"]!.append("HI")
//          //  tableArray["New Group"]!.append("Hi")
            letterTableView.reloadData()
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
    func loadCards(acard: Card) {
        charArray = acard.word?.map { String($0) }
        
        for str in charArray! {
                tableArray["New Group"]?.append(str)
            
        }
    }
//        sameMeanings = realm.objects(SameMeaning.self).filter("title == %@", acard.meaning!)
//        if sameMeanings != nil {
//            for sameM in sameMeanings! {
//                tableArray["Same Meaning"]?.append(sameM.title!)
//            }
//        }
//        let samemeaningword = realm.objects(Card.self).filter("meaning == %@", acard.meaning!).first
//        if samemeaningword != acard {
//        tableArray["New Same Meaning"]?.append(samemeaningword?.meaning! ?? "hello")
//        }
//            sameMeanings = realm.objects(SameMeaning.self).filter("title == %@", acard.meaning!)
//            if sameMeanings != nil {
//                    for sameM in sameMeanings! {
//                        tableArray["Same Meaning"]?.append(sameM.title!)
//                    }
//        
//            }else{
//                cards = realm.objects(Card.self).filter("meaning == %@", acard.meaning!)
//        
//                    if cards != nil {
//                        for card in cards! {
//                        tableArray["New Same Meaning"]?.append(card.word!)
//                            }
//                    }
//                }
    }

extension CreateViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.keys.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableArray.keys.sorted()[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableArray[(tableArray.keys.sorted()[section])]!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        groupName = self.tableView(tableView, titleForHeaderInSection: indexPath.row)
//        print(groupName!)
       let cell = tableView.dequeueReusableCell(withIdentifier: "CardGroupCell", for: indexPath) as! TableViewCell1
        cell.textLabel?.text = "hi"
//
        return cell
    }
//   @objc func addGroup(sender: UIButton){
//        let controller = DJSemiModalViewController()
//        configurePopUpView(controller: controller)
//        controller.closeButton.setTitle("Save", for: .normal)
//        controller.presentOn(presentingViewController: self, animated: true, onDismiss: {
//            let agroup = Group()
//            agroup.title = self.tfGroup.text
//            agroup.date = Date()
//            agroup.desc = self.tvDesc.text
//            self.save(group: agroup)
//        })
//    }
    @objc func addCard(sender: UIButton){
        let controller = DJSemiModalViewController()
        configurePopUpView(controller: controller)
        controller.closeButton.setTitle("Save", for: .normal)
        controller.presentOn(presentingViewController: self, animated: true, onDismiss: {
            let cat = SameMeaning()
            cat.title = self.tfGroup.text
            cat.date = Date()
            cat.desc = self.tvDesc.text
            self.saveCard(meaning: cat)
        })
    }
    func configurePopUpView(controller: DJSemiModalViewController){
               controller.title = "Add to Group"
        //        let viewGp = UIView()
        //        viewGp.frame = CGRect(x: 0, y: 20, width: 300, height: 300)
        //        controller.addArrangedSubview(view: viewGp)
                tfGroup.placeholder = "Group Name"
                tfGroup.borderStyle = .none
                tfGroup.backgroundColor = UIColor(named: "Color2")
                tfGroup.isEnabled = true
                controller.addArrangedSubview(view: tfGroup, height: 60)
                let spaceview = UIView()
                controller.addArrangedSubview(view: spaceview, height: 20)
                tvDesc.text = "Hello "
                tvDesc.backgroundColor = UIColor(named: "Color2")
                controller.addArrangedSubview(view: tvDesc, height: 80)
                controller.automaticallyAdjustsContentHeight = true
                
                controller.maxWidth = 420
                controller.minHeight = 400
                
                controller.titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
                
    }
//    func save(group: Group) {
//        var agroup = group
//        switch groupName {
//        case "New Same Meaning":
//            agroup = SameMeaning()
//        case "New Group":
//            agroup = Letter()
//        default: break
//           
//        }
//           do {
//               try realm.write {
//                 realm.add(agroup)
//               }
//           } catch {
//               print("Error saving new items, \(error)")
//           }
//    }
    func saveCard(meaning: SameMeaning) {
        do {
            realm.add(meaning)
        } catch {
            print("Error saving new items, \(error)")
        }
    }
    
}
