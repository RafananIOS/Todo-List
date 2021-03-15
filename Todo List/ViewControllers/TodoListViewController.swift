//
//  TodoListVC.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/10/21.
//

import UIKit

class TodoListViewController: BaseController {
    
    var viewModel:TodoListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodoListViewModel(delegate: self)
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        setupViews()
    }
    
    func setupNavBar(){
        title = viewModel.title()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
    }
    
    func setupViews(){
        let nib = UINib.init(nibName: "TodoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TodoCell")
    }
    
    @objc func tapAddButton(){
        viewModel.addTodo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

//view model
extension TodoListViewController:TodoListViewModelProtocol{
    func updateViews() {
        tableView.reloadData()
    }
    
    func segueToAddTodoViewController(){
        performSegue(withIdentifier: "todoListToAddTodo", sender: nil)
    }
}

//tableview
extension TodoListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        let todoCellViewModel = viewModel.todoCellViewModel(for: indexPath)
        cell.configureCell(for: todoCellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            viewModel.deleteForRow(at: indexPath)
        default:break
        }
    }
}

extension TodoListViewController: UITableViewDelegate{
    
}
