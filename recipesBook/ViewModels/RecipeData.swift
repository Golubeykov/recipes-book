//
//  RecipeData.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
