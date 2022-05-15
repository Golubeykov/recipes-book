//
//  RecipeData.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    func recipes (for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    var favoritesRecipes: [Recipe] {
        recipes.filter { recipe in recipe.isFavorite }
    }
    
}
