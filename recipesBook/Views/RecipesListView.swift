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
