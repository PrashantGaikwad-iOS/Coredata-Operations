//
//  ListVC.swift
//  CoreDataOperations
//
//  Created by Prashant Gaikwad on 15/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit


class ListVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var listTableView: UITableView!

    //MARK: - Properties
    var mirrorList = [MirrorList]()

    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    //MARK: - Custom Methods
    func fetchData() {
        let mirrorList = PersistanceManager.shared.fetch(MirrorList.self)
        self.mirrorList = mirrorList
        listTableView.reloadData()
    }

    func printMirrorList() {
        print(mirrorList)
    }

    func updateMirrorListObject(updateAt index: Int) {
        let currentObj = mirrorList[index]
        currentObj.ssid += " updated"
        currentObj.password += " updated"
        PersistanceManager.shared.save()
        fetchData()
    }

    func deleteMirrorListObject(updateAt index: Int) {
        let currentObj = mirrorList[index]
        PersistanceManager.shared.delete(currentObj)
        fetchData()
    }

}

//MARK: - TableView Methods
extension ListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mirrorList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = mirrorList[indexPath.row].ssid
        cell.detailTextLabel?.text = mirrorList[indexPath.row].password
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateMirrorListObject(updateAt: indexPath.row)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.deleteMirrorListObject(updateAt: indexPath.row)
        }
        return [delete]
    }
}
