//
//  FirstCustomSegue.swift
//  little game
//
//  Created by Stephen on 2021/6/13.
//

import UIKit

class FirstCustomSegue: UIStoryboardSegue {
    override func perform() {
        let firstPage = source.view as UIView
        let mainPage = destination.view as UIView

        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        mainPage.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)

        let animator = UIViewPropertyAnimator(duration: 2, curve: .linear) {
            firstPage.frame = CGRect(x: -screenWidth, y: 0, width: firstPage.frame.width, height: firstPage.frame.height)
            mainPage.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        }

        animator.startAnimation()
        source.present(destination as UIViewController, animated: false, completion: nil)
    }
}
