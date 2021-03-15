//
//  TodoListViewModel.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/15/21.
//

import Foundation
import UIKit

protocol TodoListViewModelProtocol{
    func updateViews()
    func segueToAddTodoViewController()
}

class TodoListViewModel{
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var currentUser:User!
    
    var numberOfSections = 1
    
    var numberOfRowsInSection = [Int]()
    
    var delegate:TodoListViewModelProtocol!
        
    init(delegate:TodoListViewModelProtocol) {
        self.delegate = delegate
        reloadData()
    }
    
    func viewWillAppear(){
        reloadData()
    }
    
    func reloadData(){
        currentUser = appDelegate.currentUser
        numberOfRowsInSection = [currentUser.todos?.count ?? 0]
        delegate.updateViews()
    }
    
    func title()->String{
        return (currentUser.name ?? "unnamed") + "'s Todos"
    }
    
    func addTodo(){
        delegate.segueToAddTodoViewController()
    }
    
    func deleteForRow(at indexPath:IndexPath){
        if indexPath.section == 0{
            currentUser.todos?.remove(at: indexPath.row)
            try? FileManagerHelper.updateUserInJsonFile(currentUser)
            appDelegate.currentUser = currentUser
            reloadData()
        }
    }
    
    func todoCellViewModel(for indexPath:IndexPath)->TodoCellViewModel{
        return TodoCellViewModel(for: currentUser.todos![indexPath.row])
    }
}
