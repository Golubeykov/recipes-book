//
//  ModifyIngredientsView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) {
            ingredient in
            ingredients.append(ingredient)
            newIngredient = Ingredient()
        }
        VStack {
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: {
                    addIngredientView
                })
                Spacer()
            } else {
                List {
                    ForEach(ingredients) {
                        ingredient in
                        Text(ingredient.description)
                            .listRowBackground(listBackgroundColor)
                    }
                    NavigationLink("Add another ingredient", destination: {
                        addIngredientView
                    })
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }
            }
        }.foregroundColor(listTextColor)
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var Ingreds1 = Recipe.testRecipes[0].ingredients
    @State static var Ingreds0 = [Ingredient]()
    static var previews: some View {
        ModifyIngredientsView(ingredients: $Ingreds0)
        ModifyIngredientsView(ingredients: $Ingreds1)
    }
}
