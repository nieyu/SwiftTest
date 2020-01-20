//
//  ViewController.swift
//  CoreDataTest
//
//  Created by nie yu on 2020/1/9.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var _context: NSManagedObjectContext?
    var _dataSource: [Person] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        createSqlite()
//        SSCoreDataManager.shareInstance.databaseName = "Person"
//        var model = NSEntityDescription.insertNewObject(forEntityName: "Person", into: SSCoreDataManager.shareInstance.context) as! Person
//        model.name = "张三"
//        model.age = 16
//        SSCoreDataManager.shareInstance.insert(model: model)
//        let p: [Person] = SSCoreDataManager.shareInstance.query(model: model) ?? [Person]()
//        print(p.count)

    }

    private func createSqlite() {
                
        guard let personPath = Bundle.main.path(forResource: "Person", ofType: "momd") else {
            print("没有找到资源")
            return
        }
        let personURL: URL = URL.init(fileURLWithPath: personPath)
        
        //创建模型
        guard let model = NSManagedObjectModel.init(contentsOf: personURL) else {
            print("NSManagedObjectModel 创建失败")
            return
        }
        
        //创建持久化对象
        let storeCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
    
        var docStr: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let sqlPath: String = docStr + "/coreData.sqlite"
        print("sqlPath \(sqlPath)")
        let sqlURL: URL = URL.init(fileURLWithPath: sqlPath)
        
        do {
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                    configurationName: nil,
                                                    at: sqlURL,
                                                    options: nil)
        } catch {
            
            print("添加数据库失败\(error.localizedDescription)")
            
        }
        
        _context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        _context!.persistentStoreCoordinator = storeCoordinator
    }
    
    @IBAction func insert(_ sender: UIButton) {
        guard let context = _context else {
            print("context为空")
            return
        }
        let person: Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.id = "9527"
        person.age = Int16(arc4random() % 20)
        person.name = "yunie" + "\(person.age)"
        person.sex = true
        
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            if let result = try _context?.fetch(fetchRequest) {
                _dataSource = result
                tableView.reloadData()
            }
            try _context?.save()
        } catch {
            print("insert fetchRequest error\(error.localizedDescription)")
        }
        
        //        let results = SSCoreDataManager.shareInstance.insert(model: person)
        //        self._dataSource = results!
        //        self.tableView.reloadData()
        
    }
    
    @IBAction func deleteAA(_ sender: UIButton) {
        
//        let model = Person.init(context: SSCoreDataManager.shareInstance.context)
//        model.name = "yunie"
//        SSCoreDataManager.shareInstance.delete(model: model)
//        let p: [Person] = SSCoreDataManager.shareInstance.query(model: Person.self) ?? [Person]()
//        self._dataSource = p
//        self.tableView.reloadData()
//        print(p.count)
        //BEGINSWITH
        //CONTAINS
        //ENDSWITH
        let deleteRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let predicate: NSPredicate = NSPredicate.init(format: "name CONTAINS %@", "nie")
        deleteRequest.predicate = predicate
        do {
            let _deleteArray = try _context?.fetch(deleteRequest)
            if let deleteArray = _deleteArray {
                deleteArray.forEach { (item) in
                    _context?.delete(item)
                }
                try _context?.save()
            }

            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
            if let result = try _context?.fetch(fetchRequest) {
                _dataSource = result
                tableView.reloadData()
            }

        } catch {
            print("deleteAA request error \(error.localizedDescription)")
        }
    }
    
    @IBAction func change(_ sender: UIButton) {
        let changeRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let predicate: NSPredicate = NSPredicate.init(format: "age < %d", 10)
        changeRequest.predicate = predicate
        
        do {
            let result = try _context?.fetch(changeRequest)
            if let _result = result {
                _result.forEach { (person) in
                    person.age += 1
                }
            }
            try _context?.save()
            
            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
            if let result = try _context?.fetch(fetchRequest) {
                _dataSource = result
                tableView.reloadData()
            }
            
        } catch {
            print("change request error \(error.localizedDescription)")
        }
    }
    
    @IBAction func query(_ sender: UIButton) {
//        let result = SSCoreDataManager.shareInstance.query(model: Person.self)
//        _dataSource = result!
//        tableView.reloadData()
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            if let result = try _context?.fetch(fetchRequest) {
                _dataSource = result
                tableView.reloadData()
            }
        } catch {
            print("query fetchRequest error\(error.localizedDescription)")
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
        cell.ageLabel.text = "\(_dataSource[indexPath.row].age)"
        cell.nameLabel.text = _dataSource[indexPath.row].name
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
