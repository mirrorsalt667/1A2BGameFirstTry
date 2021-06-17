//
//  SecondCustomSegue.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/17.
//

import UIKit

class SecondCustomSegue: UIStoryboardSegue {
    
    override func perform() {
        let gamePage = self.source.view as UIView
        let pausePage = self.destination.view as UIView
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let helfScreenWidth = screenWidth / 2
        let helfScreenHeight = screenHeight / 2
        
        pausePage.frame = CGRect(x: helfScreenWidth, y: helfScreenHeight, width: 0, height: 0)
        gamePage.alpha = 1
        
        let animator = UIViewPropertyAnimator(duration: 0.8, curve: .linear) {
            gamePage.alpha = 0
            pausePage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }
        
        animator.startAnimation()
        self.source.present(self.destination as UIViewController, animated: false, completion: nil)
    }

}
