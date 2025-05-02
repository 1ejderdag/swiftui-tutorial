//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ejder Dağ on 2.05.2025.
//

import Foundation

struct ExpenseItem: Identifiable, Codable { // identifiable protokolü uygulandığında artık ForEach ile döngü içerisinde kullanırken id: \.id yazmamıza gerek kalmadı. Çünkü o öğe zaten bir id'ye sahip ve ForEach direkt o id yi kullanacaktır. 
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
