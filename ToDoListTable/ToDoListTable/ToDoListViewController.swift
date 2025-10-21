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
  var tableView : UITableView?
  var addItemButton : UIButton?
//  var titleLabel = UILabel()
//  var tableView = UITableView()
//  var addItemButton = UIButton()
  let placeholderItemString = "New Item"
  
  // MARK: Data Models
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var models = [Item]()

//  required init?(coder: NSCoder) {
//    self.titleLabel = UILabel()
//    self.tableView = UITableView()
//    self.addItemButton = UIButton()
//    super.init(nibName: nil, bundle: nil)
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    setUpTitleLabel()
    setUpTableView()
    setUpAddItemButton()
    setUpLayout()
    
    // move this to init?
    do {
      try models = context.fetch(Item.fetchRequest())
    } catch {
      NSLog("Failed to fetch To Do List Items.")
    }
  }

  // MARK: - Setup Methods
  func setUpTitleLabel() {
    titleLabel = UILabel()
    titleLabel!.text = "To Do"
    titleLabel!.font = UIFont.boldSystemFont(ofSize: 24)
    titleLabel!.textAlignment = .center
    titleLabel!.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel!)
  }
  
  func setUpTableView() {
    tableView = UITableView()
    tableView!.translatesAutoresizingMaskIntoConstraints = false
    tableView!.delegate = self
    tableView!.dataSource = self
    tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView!.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView!)
  }
  
  func setUpAddItemButton() {
    addItemButton = UIButton()
    addItemButton!.setTitle("＋", for: .normal)
    addItemButton!.setTitleColor(.black, for: .normal)
    addItemButton!.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    addItemButton!.layer.borderWidth = 2.0
    addItemButton!.layer.borderColor = UIColor.black.cgColor
    addItemButton!.addTarget(self, action: #selector(addItemAndScroll), for: .touchUpInside)
    addItemButton!.contentVerticalAlignment = .center
    addItemButton!.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(addItemButton!)
  }

  func setUpLayout() {
    NSLayoutConstraint.activate([

      // Title label constraints
      titleLabel!.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 16
      ),
      titleLabel!.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      titleLabel!.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),

      // TableView constraints
      tableView!.topAnchor.constraint(
        equalTo: titleLabel!.bottomAnchor,
        constant: 8
      ),
      tableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      // AddItemButton constraints
      addItemButton!.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      addItemButton!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
      addItemButton!.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
      addItemButton!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    addItemButton!.layer.cornerRadius = addItemButton!.frame.height / 2
    addItemButton!.layer.masksToBounds = true
  }

  func itemAtIndex(index: Int)->String {
    return models[index].name!
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
    tableView?.reloadData()
    tableView?.scrollToRow(at: IndexPath(row: models.count - 1, section: 0), at: .bottom, animated: true)
  }
  
  func didTapSave(index: Int, text: String) {
    updateItem(at: index, with: text)
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to update To Do List Item.")
    }
    
    tableView?.reloadData()
  }
  
  func delete(at index:Int) {
    // is both needed?
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
    
    tableView?.reloadData()
    tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
  }
}
