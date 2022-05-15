//
//  RecipeDetailView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject var recipeData: RecipeData
    
    @Binding var recipe: Recipe
    @State private var isPresenting = false
    
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.title3)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.title3)
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
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                        HStack {
                            Text("\(index + 1)")
                                .bold()
                            direction.isOptional ? Text("(Optional step) \(direction.description)") : Text(direction.description)
                        }
                        }
                    }
                    .foregroundColor(listTextColor)
                }, header: { Text("Directions") })
                .listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                HStack {
                Button("Edit") {
                    isPresenting = true
                }
                Button(action: {
                    recipe.isFavorite.toggle()
                }, label: {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                })
                }
            })
            ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
        .sheet(isPresented: $isPresenting, content: {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction, content: {
                            Button("Save") {
                                isPresenting = false
                            }
                        })
                    }
            }
        })
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationView {
        RecipeDetailView(recipe: $recipe)
        }
    }
}
