//
//  ModifyIngredientView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

struct ModifyIngredientView: View {
    @State var ingredient: Ingredient = Ingredient(name: "", quantity: 0.0, unit: .g)
    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                HStack {
                    Text("Quantity:")
                    Spacer()
                    TextField("0", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                        .keyboardType(.numbersAndPunctuation)
                    //Text(String(format: "%g", ingredient.quantity))
                    //Выше закомментирована реализация Stepper с шагом 0.5, но эта реализация не позволяет вводить данные вручную, без Stepper. В итоге реализован вариант с NumberFormatter.
                    
                }
            }
            HStack {
                Text("Unit")
                Spacer()
                Picker("", selection: $ingredient.unit, content: {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue) }
                })
                .pickerStyle(.menu)
            }
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
        
}
}

struct ModifyIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyIngredientView()
    }
}
