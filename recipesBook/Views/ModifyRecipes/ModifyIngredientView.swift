//
//  ModifyIngredientView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
                .listRowBackground(listBackgroundColor)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                HStack {
                    Text("Quantity:")
                    Spacer()
                    TextField("0", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                        .keyboardType(.numbersAndPunctuation)
                    //Text(String(format: "%g", ingredient.quantity))
                    //Выше закомментирована реализация Stepper с шагом 0.5, но эта реализация не позволяет вводить данные вручную, без Stepper. В итоге реализован вариант с NumberFormatter.
                    
                }
            }.listRowBackground(listBackgroundColor)
            HStack {
                Text("Unit")
                Spacer()
                Picker("", selection: $ingredient.unit, content: {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue) }
                })
                .pickerStyle(.menu)
            }.listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
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
    @State static var ingred0 = Ingredient()
    @State static var ingred1 = Recipe.testRecipes[0].ingredients[0]
    static var previews: some View {
        ModifyIngredientView(ingredient: $ingred0) {
            ingredient in
            print(ingredient)
        }
        ModifyIngredientView(ingredient: $ingred1) {
            ingredient in
            print(ingredient)
        }
    }
}
