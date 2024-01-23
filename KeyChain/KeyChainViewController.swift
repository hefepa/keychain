//
//  KeyChainViewController.swift
//  KeyChain
//
//  Created by WEMA on 22/01/2024.
//

import UIKit

class KeyChainViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var retrieveButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var emptyTextFieldLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        passwordTextField.placeholder = "Enter your password"
        emptyTextFieldLabel.text = ""
        outputLabel.text = ""
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        //passwordTextField.text = ""
        let password = passwordTextField.text!
        if password.isEmpty{
            emptyTextFieldLabel.text = "Enter your password into the field"
        }else{
            emptyTextFieldLabel.text = ""
            let storedPassword = AuthData(accessToken: password, refreshToken: "Wema")
            KeychainHelper.shared.save(storedPassword, account: "hefepa")
            passwordTextField.text = ""
        }

    }
    
    @IBAction func retrieveClicked(_ sender: Any) {
        let result = KeychainHelper.shared.read(account: "hefepa", type: AuthData.self)
        outputLabel.text = result?.accessToken
    }
}
