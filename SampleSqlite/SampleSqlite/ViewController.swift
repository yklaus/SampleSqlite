//
//  ViewController.swift
//  SampleSqlite
//
//  Created by SungYu on 2018. 8. 1..
//  Copyright © 2018년 Sung. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection!

    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")

            database = try Connection(fileUrl.path)
        } catch {
            print(error)
        }
    }

    @IBAction func createTable() {
        print("CREATE TAPPED")

        let createTable = self.usersTable.create { table in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
        }

        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }


    }

    @IBAction func insertUser() {
        print("INSERT TAPPED")

        let alert = UIAlertController(title: "Insert User", message: nil, preferredStyle: .alert)

        alert.addTextField { (tf) in
            tf.placeholder = "Name"
        }

        alert.addTextField { (tf) in
            tf.placeholder = "Email"
        }

        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                  let email = alert.textFields?.last?.text
                    else {
                return
            }
            print(name)
            print(email)

        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    @IBAction func listUsers() {
        print("LIST TAPPED")

    }

    @IBAction func updateUser() {
        print("UPDATE TAPPED")

        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)

        alert.addTextField { (tf) in
            tf.placeholder = "User ID"
        }

        alert.addTextField { (tf) in
            tf.placeholder = "Email"
        }

        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                  let email = alert.textFields?.last?.text
                    else {
                return
            }
            print(userIdString)
            print(email)

        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func deleteUser() {
        print("DELETE TAPPED")

        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)

        alert.addTextField { (tf) in
            tf.placeholder = "User ID"
        }

        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text else {
                return
            }
            print(userIdString)

        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

