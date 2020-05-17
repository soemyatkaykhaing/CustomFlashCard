//
//  CreateViewController.swift
//  CustomFlashCard
//
//  Created by MacBook on 12/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
//MARK: Vars
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var cardTap: UITapGestureRecognizer!
    
    @IBOutlet weak var btnCreateCard: UIButton!
    var front: UIView!
    var back: UIView!
    var frontLabel : UILabel!
    var backLabel: UILabel!
    var showingBack = true
    override func viewDidAppear(_ animated: Bool) {
        let width = self.cardView.frame.width
        let height = self.cardView.frame.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        cardTap.addTarget(self, action: #selector(self.tapped(_:)))
        front = UIView(frame: rect)
        back = UIView(frame: rect)
        front.backgroundColor = .lightGray
        back.backgroundColor = .tertiaryLabel
        cardView.isUserInteractionEnabled = true
        cardView.addSubview(back)
        btnCreateCard.layer.shadowColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnCreateCard.layer.cornerRadius = 20
        btnCreateCard.layer.shadowRadius = 10
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        var showingSide = front
        var hiddenSide = back
        if showingBack {
            (showingSide, hiddenSide) = (back, front)
        }
        UIView.transition(from: showingSide!,
                          to: hiddenSide!,
                duration: 0.7,
                options: UIView.AnimationOptions.transitionFlipFromRight,
                completion: nil)
        
        showingBack = !showingBack
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
