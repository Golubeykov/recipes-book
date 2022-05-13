//
//  ModifyRecipeView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 11.05.2022.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    @State private var selection = Selection.main
    
    var body: some View {
        
        VStack {
            Picker("Select recipe component", selection: $selection, content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
                
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                Text("Main edit")
            case .ingredients:
                Text("Ingredients")
            case .directions:
                Text("Directions")
            }
            Spacer()
        }
    }
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
