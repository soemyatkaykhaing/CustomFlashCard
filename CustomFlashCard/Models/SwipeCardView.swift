//
//  SwipeCardView.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation

import UIKit

class SwipeCardView : UIView {
   
    //MARK: - Properties
    var swipeView : UIView!
    var shadowView : UIView!
    var imageView: UIImageView!
    var view: UIView!
    var label = UILabel()
    var moreButton = UIButton()
    var delegate : SwipeCardsDelegate?
    var divisor : CGFloat = 0
    let baseView = UIView()
    var dataSource : Card? {
        didSet {
            swipeView.backgroundColor = UIColor(named: "GreyCustom")
            label.text = dataSource?.word
        }
    }
    //MARK: - Init
     override init(frame: CGRect) {
        super.init(frame: .zero)
        configureShadowView()
        configureSwipeView()
        configureLabelView()
        addPanGestureOnCards()
        configureTapGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configuration
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor(named: "PupleCustom")?.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    func configureSwipeView() {
        swipeView = UIView()
        swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    func configureLabelView() {
        swipeView.addSubview(label)
        label.textColor = UIColor(named: "PupleCustom")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: swipeView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
        let _ = ((UIScreen.main.bounds.width / 2) - card.center.x)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if (card.center.x) > 400 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < -65 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
        print(swipeView.frame.width)
        print(swipeView.frame.height)

        let card = sender.view as! SwipeCardView
        UIView.transition(with: card, duration: 0.7, options: UIView.AnimationOptions.transitionFlipFromRight
            , animations: nil, completion: nil)
        if label.text == dataSource?.word {
            label.text = dataSource?.meaning
        }else{
            label.text = dataSource?.word
        }
    }
}
