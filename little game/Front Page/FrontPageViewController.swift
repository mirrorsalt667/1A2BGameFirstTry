//
//  FrontPageViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/13.
//

import UIKit

final class FrontPageViewController: UIViewController {
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var tenTimesButton: UIButton!
    @IBOutlet var explanationTextView: UITextView!

    private let frontPageStyle = FrontPageStyle()

    override func viewDidLoad() {
        super.viewDidLoad()
        frontPageStyle.textViewStyle(explanationTextView)
        frontPageStyle.buttonStyle(startGameButton.layer)
        frontPageStyle.buttonStyle(tenTimesButton.layer)
    }

    @IBAction private func startGameButton(_ sender: Any) {
        performSegue(withIdentifier: "idFirstSegue", sender: self)
    }

    @IBAction private func tenTimesButton(_ sender: Any) {
        performSegue(withIdentifier: "tenTimesSegue", sender: self)
    }
}
