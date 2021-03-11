//
//  TodoCellViewModel.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/10/21.
//

import Foundation

struct TodoCellViewModel{
    var todoString:String
    
    init(for string:String) {
        self.todoString = string
    }
}
