//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Linda Ryan on 2020-11-05.
//  Copyright © 2020 Linda Ryan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var item: ToDoItem
    
    init(item: ToDoItem) {
        
        self.item = item

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
         descriptionLabel.text = item.description
         dateCreatedLabel.text = "Created: " + item.dateCreatedAsString()
         dateCompletedLabel.text = ""
         completedSwitch.isOn = item.completed
         dateCompletedLabel.isHidden = true

         // change colour/opacity of item detail view
         view.backgroundColor = UIColor(white: 1, alpha: 1)

         // load
         view.addSubview(descriptionLabel)
         view.addSubview(dateCreatedLabel)
         view.addSubview(dateCompletedLabel)
         view.addSubview(completedSwitch)
         view.addSubview(backButton)
         // set constraints appropriately
         view.setNeedsUpdateConstraints()
    }
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var dateCompletedLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    // switch to control the state of the item
    lazy var completedSwitch: UISwitch! = {
        let view = UISwitch()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = false
        
        view.addTarget(self, action: #selector(onCompleteClicked), for: .valueChanged)

        return view
    }()
    
    @objc func onCompleteClicked(completedSwitch: UISwitch) {
        if(completedSwitch.isOn) {
            // dateCompletedLabel is visible with current date
            dateCompletedLabel.text = "Complete: " + item.dateCompletedAsString()
            dateCompletedLabel.isHidden = false
        } else {
            dateCompletedLabel.text = ""
            dateCompletedLabel.isHidden = true
        }
    }
    lazy var backButton: UIButton! = {
        let view = UIButton()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Back", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onBackClicked), for: .touchDown)
        
        return view
    }()

    @objc func onBackClicked() {
        // on click button dismisses the detail view
        self.dismiss(animated: false, completion: nil)
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide

        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15).isActive = true
        backButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        dateCreatedLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant:10 ).isActive = true
        
        completedSwitch.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        completedSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        dateCompletedLabel.topAnchor.constraint(equalTo: dateCreatedLabel.bottomAnchor, constant: 10).isActive = true
        dateCompletedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant:10 ).isActive = true
  
        super.updateViewConstraints()
    }
}
















