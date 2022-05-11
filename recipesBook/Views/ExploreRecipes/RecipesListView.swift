//
//  ContentView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject var recipeData: RecipeData
    var category: MainInformation.Category
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) {
                recipe in
                NavigationLink(destination: { RecipeDetailView(recipe: recipe) }, label: {
                    Text(recipe.mainInformation.name)
                })
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            })
        })
        .sheet(isPresented: $isPresenting, content: {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        })
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            if newRecipe.isValid {
                            Button("Add") {
                                recipeData.add(recipe: newRecipe)
                                isPresenting = false
                            }
                        }
                        })
                    })
            }
            .navigationTitle("Add a New Recipe")
        })
    }
}

extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    var navigationTitle: String {
        "\(category.rawValue) recipes"
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
    }
}
