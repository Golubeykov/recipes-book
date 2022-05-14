//
//  ModifyIngredientsView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    init()
}

protocol ModifyComponentView: View {
    associatedtype Component: Identifiable
    init(component: Binding<Component>, createAction: @escaping (Component)-> Void)
}

struct ModifyComponentsView <Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        let addComponentView = DestinationView(component: $newComponent) {
            component in
            components.append(component)
            newComponent = Component()
        }
        VStack {
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first component", destination: {
                    addComponentView
                })
                Spacer()
            } else {
                List {
                    ForEach(components) {
                        component in
                        Text(component.description)
                            .listRowBackground(listBackgroundColor)
                    }
                    NavigationLink("Add another component", destination: {
                        addComponentView
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
        ModifyComponentsView <Ingredient, ModifyIngredientView>(components: $Ingreds0)
        ModifyComponentsView <Ingredient, ModifyIngredientView>(components: $Ingreds1)
    }
}
