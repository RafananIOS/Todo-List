//
//  LoginVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/9/21.
//

import UIKit

class LoginViewController: BaseController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel:LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(delegate: self)
        usernameTextField.addTarget(self, action: #selector(returnKey), for: .primaryActionTriggered)
        passwordTextField.addTarget(self, action: #selector(returnKey), for: .primaryActionTriggered)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func returnKey(){
        view.endEditing(true)
    }
    
    @IBAction func OnTapLogin(_ sender: UIButton) {
        do{
            try viewModel.verifyUserCredentials(username: usernameTextField.text!, password: passwordTextField.text!)
        }catch{
            showAlert(message:error.localizedDescription)
        }
    }
    
    func goToMain(){
        performSegue(withIdentifier: "loginToMain", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TodoListViewController{
            navigationController?.navigationBar.isHidden = false
        }
    }
}

extension LoginViewController:LoginViewModelProtocol{
    
    func loginResult(isSucess: Bool) {
        if isSucess{
            goToMain()
        }else{
            showAlert(message:"Wrong username or password")
        }
    }
}
