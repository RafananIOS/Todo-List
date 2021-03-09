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
        // Do any additional setup after loading the view.
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
        do{
            let fetchRequest:NSFetchRequest = User.fetchRequest()
            let users = try context.fetch(fetchRequest)
            if users.contains(where: {
                $0.username == username && $0.password == password
            }){
                print("Login successful")
            }else{
                showAlert(message:"Wrong username or password")
            }
        }catch{
            showAlert(message:"Fetching error")
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
