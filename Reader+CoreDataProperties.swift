//
//  Reader+CoreDataProperties.swift
//  BookClubSwift
//
//  Created by Yemi Ajibola on 1/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Reader {

    @NSManaged var name: String?
    @NSManaged var isFriend: NSNumber?
    @NSManaged var books: NSSet?
    @NSManaged var comments: NSSet?

}
