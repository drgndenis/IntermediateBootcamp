//
//  LearnGenerics.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 16.01.2024.
//

import SwiftUI


// Model
struct Generics<T> {
    let info: T?
    
    func removeInfo() -> Generics {
        Generics(info: nil)
    }
}

// ViewModel
class GenericsViewModel: ObservableObject {
    @Published var genericsString = Generics(info: "Hello Guys!")
    @Published var genericsInt = Generics(info: 4)
    
    
    func remove() {
        genericsString = genericsString.removeInfo()
        genericsInt = genericsInt.removeInfo()
    }
}

// Second View
struct GenericsView<T: View>: View {
    let content: T
    let title: String
    
    
    var body: some View {
        HStack {
            content
            Text(title)
        }
    }
}

// Main View
struct LearnGenerics: View {
    @StateObject var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericsView(
                content: Circle()
                    .frame(width: 30),
                title: "@username")
            Text(vm.genericsString.info ?? "no data")
            Text(vm.genericsInt.info?.description ?? "no data in this info")
        }
        .onTapGesture {
            vm.remove()
        }
    }
}

#Preview {
    LearnGenerics()
}
