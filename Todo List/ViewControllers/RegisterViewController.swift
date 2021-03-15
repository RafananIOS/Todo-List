//
//  RegisterVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/9/21.
//

import UIKit

class RegisterViewController: BaseController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel:RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel(delegate: self)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func OnTapRegister(_ sender: UIButton) {
        do{
            try viewModel.verifyRegistration(name:nameTextField.text!,username: userTextField.text!, password: passwordTextField.text!)
        }catch{
            showAlert(message: error.localizedDescription)
        }
    }
}

extension RegisterViewController:RegisterViewModelProtocol{
    func registrationSuccessful() {
        navigationController?.popViewController(animated: true)
    }
}
