//
//  LoginVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/9/21.
//

import UIKit
import CoreData

class LoginVC: BaseController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func OnTapLogin(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            showAlert(message:"Invalid Input")
            return
        }
        if username.isEmpty || password.isEmpty{
            showAlert(message:"Invalid Input")
            return
        }
        
        let users = getUsersFromJsonFile()
        if let user = users.first(where: {
            $0.username == username && $0.password == password
        }){
            appDelegate.currentUser = user
            goToMain()
        }else{
            showAlert(message:"Wrong username or password")
        }
    }
    
    func goToMain(){
        performSegue(withIdentifier: "loginToMain", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TodoListVC{
            navigationController?.navigationBar.isHidden = false
        }
    }
}
