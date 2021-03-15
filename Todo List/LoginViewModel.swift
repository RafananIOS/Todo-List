//
//  LoginViewModel.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/12/21.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol{
    func loginResult(isSucess:Bool)
}

class LoginViewModel{
    
    var delegate:LoginViewModelProtocol!
    
    var appDelegate:AppDelegate!
    
    init(delegate:LoginViewModelProtocol){
        self.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        self.delegate = delegate
    }
    
    func verifyUserCredentials(username:String,password:String) throws {
        let users = try FileManagerHelper.getUsersFromJsonFile()
        if let currentUser = users.first(where: {
            $0.username == username && $0.password == password
        }){
            print("how")
            appDelegate.currentUser = currentUser
            delegate.loginResult(isSucess: true)
        }else{
            delegate.loginResult(isSucess: false)
        }
    }
}
