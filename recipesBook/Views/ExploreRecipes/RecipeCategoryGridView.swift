//
//  RecipeCategoryGridView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 10.05.2022.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
            LazyVGrid (columns: [GridItem(), GridItem()], content: {
                ForEach(MainInformation.Category.allCases, id: \.self) {
                    category in
                    NavigationLink(destination: RecipesListView(category: category)
                        /*.environmentObject(recipeData)*/, label: { CategoryView(category: category) })
                }
            })
            .navigationTitle("Categories")
            }
            }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.5)
            Text(category.rawValue)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}
