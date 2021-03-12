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
    
    lazy var container = appDelegate.persistentContainer
    
    lazy var context = container.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title:String? = "Error",message:String? = ""){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //        alert.present(self, animated: true, completion: nil)
        self.present(alert, animated: true)
    }
    
    func fetchStoreFromContext()->Store{
        let fetchRequest:NSFetchRequest = Store.fetchRequest()
        fetchRequest.fetchLimit = 1
        var store:Store?
        do{
            store = try context.fetch(fetchRequest).first
        }catch{
            showAlert(message:"Error Fetching")
        }
        
        return store ?? Store(context: context)
    }
    
    func getUsersFromContext() -> [User]{
        var users = [User]()
        let store = fetchStoreFromContext()
        guard let jsonObject = store.jsonObject else { return users }
        var json = [String:Any]()
        
        do{
            let data = jsonObject as! Data
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        }catch{
            showAlert(message: "Error Parsing")
            return [User]()
        }
        
        let usersJson:[[String:Any]] = ( json["users"] as? [[String : Any]] ) ?? [[String:Any]]()
        
        for user in usersJson{
            let username = user["username"] as? String
            let password = user["password"] as? String
            let todos = user["todos"] as? [String]
            users.append(User(username: username, password: password, todos: todos))
        }
        
        return users
    }
    
    func saveUsersToContext(_ userModels:[User]){
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
        
        if JSONSerialization.isValidJSONObject(jsonObject){
            let data = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            context.delete(fetchStoreFromContext())
            let store = Store(context: context)
            store.jsonObject = data as NSObject
            try? context.save()
        }else{
            showAlert(message:"Cannot be converted into JSON")
        }
        
        
        
    }
}
