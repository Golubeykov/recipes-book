//
//  ModifyIngredientsView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 14.05.2022.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible, Codable {
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
    
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {

        let addComponentView = DestinationView(component: $newComponent) {
            component in
            components.append(component)
            newComponent = Component()
        }.navigationTitle("Add a \(Component.singularName().capitalized)")
        VStack {
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: {
                    addComponentView
                })
                Spacer()
            } else {
                HStack {
                    Button(isEditing ? "Done" : "Delete / change order of \(Component.pluralName())", action: {
                    isEditing.toggle()
                    editMode = isEditing ? .active : .inactive
                    })
                    .padding()
                    Spacer()
                }
                List {
                    ForEach(components.indices, id:\.self) { index in
                        let component = components[index]
                        let editComponentView = DestinationView(component: $components[index]) {
                            _ in return
                        }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                        NavigationLink(component.description, destination: editComponentView)
                    }
                    .onDelete { components.remove(atOffsets: $0) }
                    .onMove { indices, newOffset in
                        components.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())", destination: {
                        addComponentView
                    })
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }.environment(\.editMode, $editMode)
            }
        }.foregroundColor(listTextColor)
    }
}
extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var Ingreds1 = Recipe.testRecipes[0].ingredients
    @State static var Ingreds0 = [Ingredient]()
    static var previews: some View {
        NavigationView {
        ModifyComponentsView <Ingredient, ModifyIngredientView>(components: $Ingreds0)
                .navigationTitle("Edit ingredients")
        }
        NavigationView {
        ModifyComponentsView <Ingredient, ModifyIngredientView>(components: $Ingreds1)
                .navigationTitle("Edit ingredients")
        }
    }
}
