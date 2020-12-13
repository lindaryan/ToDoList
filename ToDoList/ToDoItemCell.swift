//
//  ToDoItemCell.swift
//  ToDoList
//
//  Created by Linda Ryan on 2020-11-05.
//  Copyright © 2020 Linda Ryan. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    var toDoItem: ToDoItem? {
        didSet {
            if let item = toDoItem {
                descriptionLabel.text = item.description
                dateCreatedLabel.text = item.dateCreatedAsString()
                
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateCreatedLabel)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(12)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(12)
        
        return view
    }()
    
    override func updateConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        descriptionLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        
        dateCreatedLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        
        super.updateConstraints()
    }
}
