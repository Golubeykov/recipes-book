//
//  ModifyIngredientsView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
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
        }.navigationTitle("Add a \(Component.singularName().capitalized)")
        VStack {
            HStack {
                Text(Component.pluralName().capitalized)
                    .font(.title)
                    .padding()
                Spacer()
                EditButton()
                    .padding()
            }
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: {
                    addComponentView
                })
                Spacer()
            } else {
                List {
                    ForEach(components.indices, id:\.self) { index in
                        let component = components[index]
                        let editComponentView = DestinationView(component: $components[index]) {
                            _ in return
                        }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                            .listRowBackground(listBackgroundColor)
                        NavigationLink(component.description, destination: editComponentView)
                    }
                    .onDelete { components.remove(atOffsets: $0) }
                    .onMove { indices, newOffset in
                        components.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    NavigationLink("Add another \(Component.singularName())", destination: {
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
