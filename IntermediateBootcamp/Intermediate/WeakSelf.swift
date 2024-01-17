//
//  WeakSelf.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 15.11.2023.
//

import SwiftUI

struct WeakSelf: View {
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink("Navigation", destination: WeakSelfSecondScreen())
                .navigationTitle("Weak-Self")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var vm = WeakSelfViewModel()
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
                    .font(.headline)
            }
        }
    }
}

class WeakSelfViewModel : ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE")
        count(value: +1)
        getData()
    }
    
    deinit {
        /* count degerimiz surekli 0 ve 1 arasinda gidiyor dispatchQueue olmadigi zaman. Bu durumda Apple eskiden ekran ilk cizildikten sonra deinit yapmiyordu ve ekran ikinci defa cizildikten sonra deinit aktif olmaya basliyordu.
         Su anki durumda ise boyle bir durum soz konusu degil bu durumda ekran ilk acildiginda yani cizildiginde init oluyor ve ekrandan cikisi yapildiginda deinit() tetikleniyor
         */
        print("DEINITIALIZE")
        count(value: -1)
    }
    
    func getData() {
        /*
         Belirli bir zaman surecek olan islemler init ediliyor fakat deinit olmuyor ve bu sebepten oturu count degeri surekli artiyor. (weak self kullanilmadiginda)
         Bu durumda olan olay aslinda soyledir. Belirli surede deinit olmayan ekran surekli cizilmeye devam ediyor ve bu durumda ram veya cpu tarafinda sorun olabilir. Bundan dolayi boyle durumlarda weak self yani zayif self kullanmak daha mantiklidir.
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 500, execute: { [weak self] in
            self?.data = "NEW DATA!!!"
        })
    }
    
    private func count(value: Int) {
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + value, forKey: "count")


    }
}


#Preview {
    WeakSelf()
}
