//
//  MirrorList+CoreDataProperties.swift
//  CoreDataOperations
//
//  Created by Prashant Gaikwad on 15/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//
//

import Foundation
import CoreData


extension MirrorList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MirrorList> {
        return NSFetchRequest<MirrorList>(entityName: "MirrorList")
    }

    @NSManaged public var ssid: String
    @NSManaged public var password: String

}
