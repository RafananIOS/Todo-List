//
//  FileManagerHelper.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/12/21.
//

import Foundation
class FileManagerHelper{
    
    static func getUsersFromJsonFile() throws -> [User]{
        
        var users = [User]()
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first else { throw FileError.jsonError}
        let pathWithFilename = documentDirectory.appendingPathComponent("user.json")
//        check if file exists, if not create one.
        if !FileManager.default.fileExists(atPath: pathWithFilename.path) {
            try saveUsersToJsonFile([])
        }
        //jsonString to jsonArray
        let stringJson = try String(contentsOf: pathWithFilename)
        guard let data = stringJson.data(using: .utf8) else {throw FileError.jsonError}
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
        
        let usersJson:[[String:Any]] = ( json?["users"] as? [[String : Any]] ) ?? [[String:Any]]()
        //parse json
        for user in usersJson{
            let username = user["username"] as? String
            let password = user["password"] as? String
            let todos = user["todos"] as? [String]
            let name = user["name"] as? String
            users.append(User(name: name,username: username, password: password, todos: todos))
        }
        
        return users
    }
    
    static func saveUsersToJsonFile(_ userModels:[User]) throws {
        print("Started saving")
        var jsonObject = [String:Any]()
        var users = [[String:Any]]()
        
        for userModel in userModels{
            var user = [String:Any]()
            user["name"] = userModel.name
            user["username"] = userModel.username
            user["password"] = userModel.password
            
            var todos = [String]()
            todos = userModel.todos ?? [String]()
            user["todos"] = todos
            users.append(user)
        }
        jsonObject["users"] = users
        
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
        let pathWithFilename = documentDirectory.appendingPathComponent("user.json")
        try data.write(to: pathWithFilename, options: .atomic)
    }
    
    static func updateUserInJsonFile(_ user:User) throws {
        var users = try getUsersFromJsonFile()
        if let index = users.firstIndex(where: {
            $0.username == user.username
        }){
            users[index] = user
        }else{
            throw FileError.jsonError
        }
        try saveUsersToJsonFile(users)
    }
    
    static func addNewUserToJsonFile(_ user:User) throws {
        var users = try getUsersFromJsonFile()
        users.append(user)
        try saveUsersToJsonFile(users)
    }
}

enum FileError:String,Error{
    case jsonError = "Json Failure"
}
