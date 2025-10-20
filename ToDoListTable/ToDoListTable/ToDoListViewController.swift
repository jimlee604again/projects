//
//  ViewController.swift
//  ToDoListTable
//
//  Created by Jimmy Lee on 10/12/25.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                              ItemEditorDelegate
{
  // MARK: UI Elements
  let titleLabel = UILabel()
  let tableView = UITableView()
  let addItemButton = UIButton()
  
  // MARK: Data Models
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var models = [Item]()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    setUpTitleLabel()
    setUpTableView()
    setUpAddItemButton()
    setUpLayout()
    
    do {
      try models = context.fetch(Item.fetchRequest())
    } catch {
      NSLog("Failed to fetch To Do List Items.")
    }
  }

  // MARK: - Setup Methods
  func setUpTitleLabel() {
    titleLabel.text = "To Do"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)
  }
  
  func setUpTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
  }
  
  func setUpAddItemButton() {
    addItemButton.setTitle("＋", for: .normal)
    addItemButton.setTitleColor(.black, for: .normal)
    addItemButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    addItemButton.layer.borderWidth = 2.0
    addItemButton.layer.borderColor = UIColor.black.cgColor
    addItemButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    addItemButton.contentVerticalAlignment = .center
    addItemButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(addItemButton)
  }

  func setUpLayout() {
    NSLayoutConstraint.activate([

      // Title label constraints
      titleLabel.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 16
      ),
      titleLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),

      // TableView constraints
      tableView.topAnchor.constraint(
        equalTo: titleLabel.bottomAnchor,
        constant: 8
      ),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      // AddItemButton constraints
      addItemButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      addItemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
      addItemButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
      addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    addItemButton.layer.cornerRadius = addItemButton.frame.height / 2
    addItemButton.layer.masksToBounds = true
  }

  // MARK: - TableView DataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "cell",
      for: indexPath
    )
    cell.textLabel?.text = models[indexPath.row].name
    return cell
  }

  // MARK: - TableView Delegate Method (optional)
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    tableView.deselectRow(at: indexPath, animated: true)
    let itemEditor = ItemEditorViewController(item: models[indexPath.row],
                                              index: indexPath.row,
                                              delegate: self)
    itemEditor.modalPresentationStyle = .overFullScreen
    present(itemEditor, animated: false)
  }
  
  @objc func addItem() {
    let newItem = Item(context: context)
    newItem.name = "New Item"
    models.append(newItem)
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to save new To Do List Item.")
    }
    
    tableView.reloadData()
    tableView.scrollToRow(at: IndexPath(row: models.count - 1, section: 0), at: .bottom, animated: true)
  }
  
  func didTapSave(item: Item, text: String) {
    item.name = text
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to update To Do List Item.")
    }
    
    tableView.reloadData()
  }
  
  func didTapDelete(item: Item, index: Int) {
    context.delete(item)
    models.remove(at: index)
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to delete To Do List Item.")
    }
    
    tableView.reloadData()
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
  }
}
