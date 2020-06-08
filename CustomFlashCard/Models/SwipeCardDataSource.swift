//
//  SwipeCardDataSource.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
    
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}
