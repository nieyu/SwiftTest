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
        createSqlite()
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
        person.name = "yunie"
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
        
    }
    
    @IBAction func deleteAA(_ sender: UIButton) {
        
    }
    
    @IBAction func change(_ sender: UIButton) {
        
    }
    
    @IBAction func query(_ sender: UIButton) {
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
