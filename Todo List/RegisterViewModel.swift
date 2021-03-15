//
//  RegisterViewModel.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/12/21.
//

import Foundation
import UIKit

protocol RegisterViewModelProtocol{
    func registrationSuccessful()
}

class RegisterViewModel{
    var delegate:RegisterViewModelProtocol!
    
    init(delegate:RegisterViewModelProtocol){
        self.delegate = delegate
    }
    
    func verifyRegistration(name:String, username:String,password:String) throws {
        
        if username.isEmpty || password.isEmpty{
            throw RegistrationError.inputEmpty
        }
        let users = try FileManagerHelper.getUsersFromJsonFile()

            
        if users.contains(where: {
            $0.username == username
        }){
            throw RegistrationError.duplicateUsername
        }else{
            let newUser = User(name: name, username: username, password: password)
            try FileManagerHelper.addNewUserToJsonFile(newUser)
            
            delegate.registrationSuccessful()
        }
    }
}

enum RegistrationError:String,Error{
    case duplicateUsername = "Username is taken"
    case inputEmpty = "Username or password is empty"
}
