//
//  ViewController.swift
//  CoreDataOperations
//
//  Created by Prashant Gaikwad on 15/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var ssidTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        // check if already exist before saving
        self.isEntityAttributeExist(ssid: ssidTF?.text ?? " ", entityName: "MirrorList")
        save()
    }

    //MARK: - Custom Methods
    func save() {
        let mirrorList = MirrorList(context: PersistanceManager.shared.context)
        mirrorList.ssid = ssidTF.text ?? ""
        mirrorList.password = passwordTF.text ?? ""
        PersistanceManager.shared.save()
    }

    func isEntityAttributeExist(ssid: String, entityName: String) {
        let managedContext = PersistanceManager.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "ssid == %@", ssid)
        let res = try! managedContext.fetch(fetchRequest)

        // delete if already exist
        if res.count > 0 {
            for obj in res {
                if (obj as! MirrorList).ssid == ssid {
                    print("already exist")
                    managedContext.delete(obj as! NSManagedObject)
                }
            }
        }
    }
    
}

