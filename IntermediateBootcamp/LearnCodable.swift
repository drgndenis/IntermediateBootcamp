//
//  LearnCodable.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 16.11.2023.
//

import SwiftUI

// Codable = Decodable + Encodable

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let point: Int
    let isPremium: Bool
    
    // This is the default initialize and we don't need the coding for this init. Because it's comes by default when we don't code the default init
    init(id: String, name: String, point: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.point = point
        self.isPremium = isPremium
    }
  
    // We don't need any of these all code lines... :O Because Swift does this behind the scene for us
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case point
//        case isPremium
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.point = try container.decode(Int.self, forKey: .point)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.point, forKey: .point)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class LearnCodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }

        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("JSONDecoder error is \(error.localizedDescription)")
        }
        
        
//        if 
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let point = dictionary["point"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            
//            let newCustomer = CustomerModel(id: id, name: name, point: point, isPremium: isPremium)
//            customer = newCustomer
//        }
    }
    
    func getJSONData() -> Data? {
        let customer = CustomerModel(id: "21212", name: "Matthew", point: 13, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String: Any] = [
//            "id" : "12345",
//            "name" : "Joe",
//            "point" : 13,
//            "isPremium" : true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        
        return jsonData
    }
}

struct LearnCodable: View {
    @StateObject var vm = LearnCodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.point)")
                Text(customer.isPremium.description)
            }
        }
        .font(.title)
        .fontWeight(.semibold)
    }
}

//#Preview {
//    LearnCodable()
//}
