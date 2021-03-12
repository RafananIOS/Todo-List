//
//  RegisterVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/9/21.
//

import UIKit
import CoreData

class RegisterVC: BaseController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnTapRegister(_ sender: UIButton) {
        //error checking
        guard let username = userTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            showAlert(message: "Invalid Input.")
            return
        }
        if username.isEmpty || password.isEmpty || name.isEmpty{
            showAlert(message: "Invalid Input")
            return
        }
        
        //check for repeat username
        var users = getUsersFromJsonFile()
        if !users.contains(where: {
            $0.username == username
        }){
            //create new user
            let newUser = User(username: username, password: password, todos: [String]())
            users.append(newUser)
            saveUsersToJsonFile(users)
            navigationController?.popViewController(animated: true)
        }else{
            showAlert(message: "Repeat Username")
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
