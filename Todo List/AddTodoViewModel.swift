//
//  AddTodoViewModel.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/15/21.
//

import Foundation
import UIKit

protocol AddTodoViewModelProtocol{
    func addTodoResult(isSuccess:Bool)
}

class AddTodoViewModel{
    var delegate:AddTodoViewModelProtocol!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(delegate:AddTodoViewModelProtocol) {
        self.delegate = delegate
    }
    
    func addTodo(_ todo:String)throws{
        if todo.isEmpty{
            delegate.addTodoResult(isSuccess: false)
        }else{
            var currentUser = appDelegate.currentUser
            currentUser.todos?.append(todo)
            appDelegate.currentUser = currentUser
            print("Call saving")
                try FileManagerHelper.updateUserInJsonFile(currentUser)
            delegate.addTodoResult(isSuccess: true)
        }
    }
}
