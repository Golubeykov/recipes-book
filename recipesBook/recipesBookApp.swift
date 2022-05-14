//
//  recipesBookApp.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import SwiftUI

@main
struct recipesBookApp: App {
    @StateObject var recipeData = RecipeData()
    var body: some Scene {
        WindowGroup {
            RecipeCategoryGridView().environmentObject(recipeData)
        }
    }
}
