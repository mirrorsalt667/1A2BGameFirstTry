//
//  FirstPageViewController.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/13.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var directionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        directionsTextView.layer.borderWidth = 1.2
        directionsTextView.layer.borderColor = UIColor(named: "MorningYellow")?.cgColor
        directionsTextView.layer.cornerRadius = 7
        startGameButton.layer.cornerRadius = 5
        startGameButton.layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        startGameButton.layer.borderWidth = 2
    }
    @IBAction func startGameButton(_ sender: Any) {
        self.performSegue(withIdentifier: "idFirstSegue", sender: self)
    }
    

}
