//
//  firstCustomSegue.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/13.
//

import UIKit

class firstCustomSegue: UIStoryboardSegue {

    override func perform() {
        let firstPage = self.source.view as UIView
        let mainPage = self.destination.view as UIView
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        mainPage.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        let animator = UIViewPropertyAnimator(duration: 2, curve: .linear) {
            firstPage.frame = CGRect(x: -screenWidth, y: 0, width: firstPage.frame.width, height: firstPage.frame.height)
            mainPage.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        }
        
        animator.startAnimation()
        self.source.present(self.destination as UIViewController, animated: false, completion: nil)
    }
    
}
