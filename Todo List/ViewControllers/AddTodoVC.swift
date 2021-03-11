//
//  AddTodoVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/11/21.
//

import UIKit

class AddTodoVC: BaseController {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoInputText: UITextField!
    @IBOutlet weak var addTodoButton: UIButton!
    
    var onComplete:((String)->Void)!
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        if !todoInputText.text!.isEmpty{
            onComplete(todoInputText.text!)
            dismiss(animated: true, completion: nil)
        }else{
            showAlert(message:"Invalid Input")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
