//
//  ItemEditorViewController.swift
//  ToDoListTable
//
//  Created by Jimmy Lee on 10/16/25.
//

import UIKit

class ItemEditorViewController : UIViewController
{
  let text : String
  var textField = UITextField()
  var saveButton = UIButton()
  var cancelButton = UIButton()
  var deleteButton = UIButton()
  
  init(text : String) {
    self.text = text
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .red
    setUpTextField()
    setUpSaveButton()
    setUpCancelButton()
    setUpDeleteButton()
    setUpLayout()
  }
  
  func setUpTextField() {
    textField.text = text
    view.addSubview(textField)
  }
  
  func setUpSaveButton() {
    saveButton.setTitle("Save", for: .normal)
    // add tap action
    view.addSubview(saveButton)
  }
  
  func setUpCancelButton() {
    cancelButton.setTitle("Cancel", for: .normal)
    // add tap action
    view.addSubview(saveButton)
  }
  
  func setUpDeleteButton() {
    cancelButton.setTitle("Delete", for: .normal)
    // add tap action
    view.addSubview(deleteButton)
  }
  
  func setUpLayout() {
    
  }
}
