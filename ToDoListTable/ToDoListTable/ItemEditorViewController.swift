//
//  ItemEditorViewController.swift
//  ToDoListTable
//
//  Created by Jimmy Lee on 10/16/25.
//

import UIKit

protocol ItemEditorDelegate {
  func didTapSave(text: String, index: Int)
  func didTapDelete(index: Int)
}

class ItemEditorViewController : UIViewController
{
  let buttonBorderWidth = 2.0
  let buttonCornerRadius = 6.0
  let buttonHeight = 40.0
  var buttonConfiguration = UIButton.Configuration.filled()
  
  let item: Item
  var textField = InsettedTextField()
  var saveButton = UIButton()
  var cancelButton = UIButton()
  var deleteButton = UIButton()
  
  let delegate: ItemEditorDelegate;
  
  init(item: Item, delegate: ItemEditorDelegate) {
    self.item = item
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
    buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10,
                                                                bottom: 10, trailing: 10)
    buttonConfiguration.baseBackgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    setUpTextField()
    setUpSaveButton()
    setUpCancelButton()
    setUpDeleteButton()
    setUpLayout()
  }
  
  func setUpTextField() {
    textField.text = item.text
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .white
    textField.layer.cornerRadius = 6.0
    textField.layer.borderWidth = 2.0
    view.addSubview(textField)
  }
  
  func setUpSaveButton() {
    saveButton.configuration = buttonConfiguration
    saveButton.configuration?.baseBackgroundColor = .init(red: 144/255.0,
                                                          green: 238/255.0,
                                                          blue: 144/255.0,
                                                          alpha: 1.0)
    saveButton.setTitle("Save", for: .normal)
    // add tap action
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.setTitleColor(.black, for: .normal)
    saveButton.layer.borderWidth = buttonBorderWidth
    saveButton.layer.cornerRadius = buttonCornerRadius
    saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    view.addSubview(saveButton)
  }
  
  func setUpCancelButton() {
    cancelButton.configuration = buttonConfiguration
    cancelButton.configuration?.baseBackgroundColor = .lightGray
    cancelButton.setTitle("Cancel", for: .normal)
    // add tap action
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.setTitleColor(.black, for: .normal)
    cancelButton.layer.borderWidth = buttonBorderWidth
    cancelButton.layer.cornerRadius = buttonCornerRadius
    cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    view.addSubview(cancelButton)
  }
  
  func setUpDeleteButton() {
    deleteButton.configuration = buttonConfiguration
    deleteButton.configuration?.baseBackgroundColor = .init(red: 255/255.0,
                                                            green: 182/255.0,
                                                            blue: 193/255.0,
                                                            alpha: 1.0)
    deleteButton.setTitle("Delete", for: .normal)
    // add tap action
    deleteButton.translatesAutoresizingMaskIntoConstraints = false
    deleteButton.setTitleColor(.black, for: .normal)
    deleteButton.layer.borderWidth = buttonBorderWidth
    deleteButton.layer.cornerRadius = buttonCornerRadius
    deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    view.addSubview(deleteButton)
  }
  
  func setUpLayout() {
    let textFieldTopInset = 80.0
    let textFieldSideInset = 40.0
    let firstButtonUpperGap = 80.0
    let secondButtonUpperGap = 30.0
    let deleteButtonVerticalGap = 200.0
    let buttonWidth = 140.0
    
    NSLayoutConstraint.activate([
      // Title Label constraints
      textField.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: textFieldTopInset
      ),
      textField.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: textFieldSideInset
      ),
      textField.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -textFieldSideInset
      ),

      saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: firstButtonUpperGap),
//      saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -butonSideInset),
//      saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4.0),
      saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      saveButton.widthAnchor.constraint(equalToConstant: buttonWidth),
      
      cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: secondButtonUpperGap),
//      cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: butonSideInset),
//      cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4.0),
      cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
      
      deleteButton.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: deleteButtonVerticalGap),
      deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      deleteButton.widthAnchor.constraint(equalToConstant: buttonWidth)
      ])
  }

  @objc func didTapSave() {
    dismiss(animated: false)
    delegate.didTapSave(text: textField.text!, index: item.index)
  }
  
  @objc func didTapCancel() {
    dismiss(animated: false)
  }
  
  @objc func didTapDelete() {
    dismiss(animated: false)
    delegate.didTapDelete(index: item.index)
  }
  
}
