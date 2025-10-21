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
  var titleLabel : UILabel?
  var listTableView : UITableView?
  var addItemButton : UIButton?
  let placeholderItemString = "New Item"
  
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
    let label = UILabel()
    label.text = "To Do"
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    titleLabel = label
  }
  
  func setUpTableView() {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    listTableView = tableView
  }

  func setUpAddItemButton() {
    let button = UIButton()
    button.setTitle("＋", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    button.layer.borderWidth = 2.0
    button.layer.borderColor = UIColor.black.cgColor
    button.addTarget(self, action: #selector(addItemAndScroll), for: .touchUpInside)
    button.contentVerticalAlignment = .center
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    addItemButton = button
  }
  
  func setUpLayout() {
    guard let unwrappedTitleLabel = titleLabel, let unwrappedTableView = listTableView,
          let unwrappedAddItemButton = addItemButton else {
      NSLog("An optional UI value is nil.")
      return
    }
    
    NSLayoutConstraint.activate([

      // Title label constraints
      unwrappedTitleLabel.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 16
      ),
      unwrappedTitleLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      unwrappedTitleLabel.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),

      // TableView constraints
      unwrappedTableView.topAnchor.constraint(
        equalTo: unwrappedTitleLabel.bottomAnchor,
        constant: 8
      ),
      unwrappedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      unwrappedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      unwrappedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      // AddItemButton constraints
      unwrappedAddItemButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      unwrappedAddItemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
      unwrappedAddItemButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
      unwrappedAddItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if let unwrappedAddItemButton = addItemButton {
      unwrappedAddItemButton.layer.cornerRadius = unwrappedAddItemButton.frame.height / 2
      unwrappedAddItemButton.layer.masksToBounds = true
    }
  }

  func itemAtIndex(index: Int)->String {
    if let name = models[index].name {
      return name
    } else {
      return ""
    }
  }

  func updateItem(at index: Int, with name: String) {
    models[index].name = name
  }

  func numberOfItems()->Int {
    return models.count
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
  
  func addItem() {
    let newItem = Item(context: context)
    newItem.name = placeholderItemString
    models.append(newItem)
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to save new To Do List Item.")
    }
  }
  
  @objc func addItemAndScroll() {
    addItem()
    listTableView?.reloadData()
    listTableView?.scrollToRow(at: IndexPath(row: models.count - 1, section: 0), at: .bottom, animated: true)
  }
  
  func didTapSave(index: Int, text: String) {
    updateItem(at: index, with: text)
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to update To Do List Item.")
    }
    
    listTableView?.reloadData()
  }
  
  func delete(at index:Int) {
    context.delete(models[index])
    models.remove(at: index)
  }
  
  func didTapDelete(item: Item, index: Int) {
    delete(at: index)
    do {
      try context.save()
    } catch {
      NSLog("Failed to delete To Do List Item.")
    }
    
    listTableView?.reloadData()
    if (models.count > 0) {
      listTableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
  }
}
