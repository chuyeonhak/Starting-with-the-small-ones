//
//  CareerRecord+CoreDataProperties.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/25.
//
//

import Foundation
import CoreData


extension CareerRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CareerRecord> {
        return NSFetchRequest<CareerRecord>(entityName: "CareerRecord")
    }

    @NSManaged public var draws: Int32
    @NSManaged public var losses: Int32
    @NSManaged public var wins: Int32

}

extension CareerRecord : Identifiable {

}
