//
//  RecipeDetailView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(content: {
                    ForEach(recipe.ingredients) {
                        ingredient in
                        Text(ingredient.description)
                    }
                    .foregroundColor(listTextColor)
                }, header: { Text("Ingredients") })
                .listRowBackground(listBackgroundColor)
                
                Section(content: {
                    ForEach(recipe.directions.indices, id: \.self) {
                        index in
                        let direction = recipe.directions[index]
                        HStack {
                            Text("\(index + 1)")
                                .bold()
                            direction.isOptional ? Text("(Optional step) \(direction.description)") : Text(direction.description)
                        }
                    }
                    .foregroundColor(listTextColor)
                }, header: { Text("Directions") })
                .listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationView {
        RecipeDetailView(recipe: recipe)
        }
    }
}
