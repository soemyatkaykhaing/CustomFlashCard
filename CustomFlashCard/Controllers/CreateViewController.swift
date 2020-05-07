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
    
    var front: UIView!
    var back: UIView!
    var frontLabel : UILabel!
    var backLabel: UILabel!
    var showingBack = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.cardView.frame.width
        let height = self.cardView.frame.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        cardTap.addTarget(self, action: #selector(self.tapped(_:)))
        front = UIView(frame: rect)
        back = UIView(frame: rect)
        front.backgroundColor = .blue
        back.backgroundColor = .orange
        cardView.isUserInteractionEnabled = true
        cardView.addSubview(back)
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
