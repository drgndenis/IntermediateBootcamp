//
//  SubscriberView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 18.11.2023.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        startTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }

    
    // bunu neden yaotigimizi anlamadım????
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            .sink { [weak self] isValid in
                self?.textIsValid = isValid
            }
            .store(in: &cancellables) // if you don't use .store (actually AnyCAncellable) .sink is don't work
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count > 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
        
    }
    
    func resetTimer() {
        count = 0
        startTimer()
    }
}

struct SubscriberView: View {
    @StateObject var vm = SubscriberViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .bold()
                .frame(height: 55)
                .background(Color("MercuryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    CheckImages(), 
                    alignment: .trailing
                )
            
            CustomButton(action: {
                
            }, text: "Submit".uppercased())
            
        }
        .padding()
        .environmentObject(vm)
    }
}

#Preview {
    SubscriberView()
}

struct CustomButton: View {
    @EnvironmentObject var  vm: SubscriberViewModel
    
    var action: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(vm.showButton ? 1.0 : 0.5)
        })
    }
}

struct CheckImages: View {
    @EnvironmentObject var vm: SubscriberViewModel
    
    var body: some View {
        ZStack {
            Image(systemName: "xmark")
                .foregroundStyle(.red)
                .opacity(
                    vm.textFieldText.count < 1 ? 0.0 :
                    vm.textIsValid ? 0.0 : 1.0)
            Image(systemName: "checkmark")
                .foregroundStyle(.green)
                .opacity(vm.textIsValid ? 1.0 : 0.0)
        }
        .font(.title)
        .padding(.trailing)
    }
}
