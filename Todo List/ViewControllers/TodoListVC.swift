//
//  TodoListVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/10/21.
//

import UIKit
import CoreData

class TodoListVC: BaseController {
    
    var user = User()
    var todos = [String]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews(){
        let nib = UINib.init(nibName: "TodoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TodoCell")
    }
    
    @objc func tapAddButton(){
        performSegue(withIdentifier: "todoListToAddTodo", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addTodoVC = segue.destination as? AddTodoVC {
            addTodoVC.onComplete = { [self] todoString in
                todos.append(todoString)
                user.todos = todos
                saveUsersToContext([user])
                tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = appDelegate.currentUser
        todos = user.todos ?? [String]()
        tableView.reloadData()
    }
    
}

extension TodoListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        let todoCellViewModel = TodoCellViewModel(for: todos[indexPath.row])
        cell.configureCell(for: todoCellViewModel)
        return cell
        
    }
    
    
}

extension TodoListVC: UITableViewDelegate{
    
}
