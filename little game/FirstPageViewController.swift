//
//  FirstPageViewController.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/13.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var tenTimesButton: UIButton!
    @IBOutlet weak var directionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        directionsTextView.layer.borderWidth = 1.2
        directionsTextView.layer.borderColor = UIColor(named: "MorningYellow")?.cgColor
        directionsTextView.layer.cornerRadius = 7
        colorOfButton(in: startGameButton.layer)
        colorOfButton(in: tenTimesButton.layer)
    }
    @IBAction func startGameButton(_ sender: Any) {
        self.performSegue(withIdentifier: "idFirstSegue", sender: self)
    }
    @IBAction func tenTimesButton(_ sender: Any) {
        self.performSegue(withIdentifier: "tenTimesSegue", sender: self)
    }
    
    
    //統一按鈕顏色
    func colorOfButton(in layer: CALayer) {
        layer.cornerRadius = 5
        layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        layer.borderWidth = 2
    }
    

}
