//
//  PlayerInfoViewController.swift
//  little game
//
//  Created by Stephen on 2024/8/22.
//

import UIKit

final class PlayerInfoViewController: UIViewController {
    // MARK: Components
    
    @IBOutlet private var backToHomePageButton: UIButton!
    @IBOutlet private var playerIdStrLabel: UILabel!
    @IBOutlet private var playerNameTextField: UITextField!
    @IBOutlet private var changeNameButton: UIButton!
    
    private let store = StoreLeaderboardModel()
    private let api = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle(changeNameButton)
        backToHomePageButton.setTitle("", for: .normal)
        
        if let player = store.loadPlayerData() {
            DispatchQueue.main.async {
                self.playerIdStrLabel.text = player.player_id_str
                self.playerNameTextField.text = player.player_name
                self.changeNameButton.isHidden = (player.has_changed == 1)
                self.playerNameTextField.isEnabled = false
            }
        } else {
            print(">>> <ERROR> Load Player Data Failed")
        }
    }
    
    // MARK: - Action
    
    @IBAction private func changeNameAction(_ sender: UIButton) {
        showChangeNameAlert(placeholder: "輸入暱稱")
    }
}

// MARK: - Methods

extension PlayerInfoViewController {
    private func buttonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(UIColor(named: "MorningDarkGreen"), for: .normal)
    }
    
    private func patchPlayerName(new name: String) {
        if let player = store.loadPlayerData() {
            api.patchPlayerName(player.id, name) { [weak self] result in
                switch result {
                case .success(let player):
                    print(player)
                    self?.showMessageAlert(title: "修改成功", message: "")
                    self?.store.savePlayerData(player)
                    self?.playerNameTextField.text = player.player_name
                    self?.changeNameButton.isHidden = (player.has_changed == 1)
                case .failure(let error):
                    print(">>> <ERROR> PATCH Player Failed: \(error)")
                    self?.showMessageAlert(title: "修改發生錯誤", message: "請稍候再試。")
                }
            }
        } else {
            print(">>> <ERROR> Load Player Data Failed")
        }
    }
    
    private func showChangeNameAlert(placeholder: String) {
        let alertController = UIAlertController(title: "修改暱稱", message: "輸入要修改的暱稱（僅能改1次）", preferredStyle: .alert)
        
        // Add a text field to the alert
        alertController.addTextField { textField in
            textField.placeholder = placeholder
            textField.delegate = self
        }
        
        // Create an OK action
        let okAction = UIAlertAction(title: "確認", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first {
                if let newName = textField.text {
                    if !newName.isEmpty {
                        self?.patchPlayerName(new: newName)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        
        // Add the action to the alert controller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
               
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    private func showMessageAlert(title: String, message: String) {
        let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
        // Create an OK action
        let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
           
        // Add the action to the alert controller
        errorAlertController.addAction(okAction)
           
        // Present the error alert
        present(errorAlertController, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate

extension PlayerInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text, including the replacement string
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 14
    }
}
