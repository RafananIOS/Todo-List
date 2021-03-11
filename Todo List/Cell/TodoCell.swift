//
//  TodoCell.swift
//  Todo List
//
//  Created by Daniel Marco S. Rafanan on Mar/11/21.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(for viewModel:TodoCellViewModel){
        todoLabel.text = viewModel.todoString
    }
    
}
