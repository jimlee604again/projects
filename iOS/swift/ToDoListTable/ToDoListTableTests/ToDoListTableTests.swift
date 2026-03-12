//
//  ToDoListTableTests.swift
//  ToDoListTableTests
//
//  Created by Jimmy Lee on 10/12/25.
//

import Testing
import Dispatch
@testable import ToDoListTable

struct ToDoListTableTests {
  var toDoListViewController: ToDoListViewController?;
  
  mutating func setUp() {
    toDoListViewController = ToDoListViewController()
  }
  
  mutating func tearDown() {
    toDoListViewController = nil;
  }
  
  @Test mutating func testBlankList() async throws {
    setUp()
    
    let numberOfItems = await toDoListViewController?.numberOfItems()
    #expect(numberOfItems == 0)
    
    tearDown()
  }
  
  @Test mutating func testAddItem() async throws {
    setUp()
    
    await toDoListViewController?.addItem()
    let numberOfItems = await toDoListViewController?.numberOfItems()
    #expect(numberOfItems == 1)
    let firstItem = await toDoListViewController?.itemAtIndex(index: 0)
    #expect(firstItem == toDoListViewController?.placeholderItemString)
    
    tearDown()
  }
  
  @Test mutating func testAddTwoItems() async throws {
    setUp()
    
    await toDoListViewController?.addItem()
    let numberOfItemsAfterOneAdd = await toDoListViewController?.numberOfItems()
    #expect(numberOfItemsAfterOneAdd == 1)
    await toDoListViewController?.addItem()
    let numberOfItemsAfterTwoAdds = await toDoListViewController?.numberOfItems()
    #expect(numberOfItemsAfterTwoAdds == 2)
    
    tearDown()
  }
  
  @Test mutating func testUpdateItem() async throws {
    setUp()
    
    let nameInput = "Walk the dog"
    await toDoListViewController?.addItem()
    await toDoListViewController?.updateItem(at: 0, with: nameInput)
    let numberOfItems = await toDoListViewController?.numberOfItems()
    let firstItem = await toDoListViewController?.itemAtIndex(index: 0)
    #expect(numberOfItems == 1)
    #expect(firstItem == nameInput)
    
    tearDown()
  }
  
  @Test mutating func testDeleteItem() async throws {
    setUp()
   
    await toDoListViewController?.addItem()
    await toDoListViewController?.addItem()
    await toDoListViewController?.addItem()
    
    await toDoListViewController?.updateItem(at: 0, with: "one")
    await toDoListViewController?.updateItem(at: 1, with: "two")
    await toDoListViewController?.updateItem(at: 2, with: "three")
    
    await toDoListViewController?.delete(at: 1)
    
    let numberOfItems = await toDoListViewController?.numberOfItems()
    let firstItem = await toDoListViewController?.itemAtIndex(index: 0)
    let secondItem = await toDoListViewController?.itemAtIndex(index: 1)
    
    #expect(numberOfItems == 2)
    #expect(firstItem == "one")
    #expect(secondItem == "three")
    
    tearDown()
  }
}
