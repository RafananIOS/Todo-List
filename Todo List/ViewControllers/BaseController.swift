//
//  BaseController.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/9/21.
//

import UIKit
import CoreData

class BaseController: UIViewController {
    // MARK: - CoreData helper
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title:String? = "Error",message:String? = ""){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func getUsersFromJsonFile() -> [User]{

        var users = [User]()

        let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
        let pathWithFilename = documentDirectory.appendingPathComponent("users.json")
        
        //check if file exists, if not create one.
        if !FileManager.default.fileExists(atPath: pathWithFilename.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: pathWithFilename.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        //jsonString to jsonArray
        let stringJson = try! String(contentsOf: pathWithFilename)
        let data = stringJson.data(using: .utf8)!
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {
            return [User]()
        }
        
        let usersJson:[[String:Any]] = ( json["users"] as? [[String : Any]] ) ?? [[String:Any]]()
        //parse json
        for user in usersJson{
            let username = user["username"] as? String
            let password = user["password"] as? String
            let todos = user["todos"] as? [String]
            users.append(User(username: username, password: password, todos: todos))
        }
        
        return users
    }
    
    func saveUsersToJsonFile(_ userModels:[User]){
        var jsonObject = [String:Any]()
        var users = [[String:Any]]()
        
        for userModel in userModels{
            var user = [String:Any]()
            user["username"] = userModel.username
            user["password"] = userModel.password
            
            var todos = [String]()
            todos = userModel.todos ?? [String]()
            user["todos"] = todos
            users.append(user)
        }
        jsonObject["users"] = users
        
        let data = try! JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        let jsonString = String(data: data, encoding: .utf8)
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("users.json")
            do {
                try jsonString!.write(to: pathWithFilename,atomically: true, encoding: .utf8)
            } catch {
                showAlert(message:"Error in json file.")
            }
        }
    }
}
