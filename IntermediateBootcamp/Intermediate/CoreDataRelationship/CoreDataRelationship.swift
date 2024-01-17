//
//  CoreDataRelationship.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 15.11.2023.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading CoraData \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("ERROR: \(error)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
}

struct CoreDataRelationship: View {
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CoreDataRelationship()
}
