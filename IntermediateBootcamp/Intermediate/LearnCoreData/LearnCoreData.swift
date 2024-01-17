//
//  LearnCoreData.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 15.11.2023.
//

import SwiftUI
import CoreData

/*
 MVVM
 Model: data point
 View: UI
 View Model: Manages data for a view
 */

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var fruits: [Fruits] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<Fruits>(entityName: "Fruits")
        
        do {
            fruits = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addFruit(text: String) {
        let newFruit = Fruits(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = fruits[index]
        container.viewContext.delete(entity)
        
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct LearnCoreData: View {
    @StateObject var vm = CoreDataViewModel()
    @State var addFruitText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter your favorite fruit..", text: $addFruitText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button(action: {
                    guard !addFruitText.isEmpty else { return }
                    vm.addFruit(text: addFruitText)
                    addFruitText = ""
                }, label: {
                    Text("Add some Fruit")
                })
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.pink)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                List {
                    ForEach(vm.fruits) { item in
                        Text(item.name ?? "")
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    LearnCoreData()
}
