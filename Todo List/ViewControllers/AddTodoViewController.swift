//
//  AddTodoVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/11/21.
//

import UIKit

class AddTodoViewController: BaseController {
    
    var viewModel:AddTodoViewModel!

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoInputText: UITextField!
    @IBOutlet weak var addTodoButton: UIButton!
        
    @IBAction func touchAddButton(_ sender: UIButton) {
        do{
            try viewModel.addTodo(todoInputText.text!)
        }catch{
            showAlert(message:error.localizedDescription)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddTodoViewModel(delegate: self)
    }
}

extension AddTodoViewController:AddTodoViewModelProtocol{
    func addTodoResult(isSuccess: Bool) {
        if isSuccess{
            todoInputText.text! = ""
        }else{
            showAlert(message:"Please write an input")
        }
    }
}
