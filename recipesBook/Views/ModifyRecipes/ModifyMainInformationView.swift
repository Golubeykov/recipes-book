//
//  ModifyMainInformationView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 13.05.2022.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Recipe name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            Section(content: {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }, header: {Text("Description")})
            HStack {
                Text("Category")
                Spacer()
                Picker("Category", selection: $mainInformation.category, content: {
                    Text(MainInformation.Category.breakfast.rawValue).tag(MainInformation.Category.breakfast)
                    Text(MainInformation.Category.dinner.rawValue).tag(MainInformation.Category.dinner)
                    Text(MainInformation.Category.lunch.rawValue).tag(MainInformation.Category.lunch)
                    Text(MainInformation.Category.dessert.rawValue).tag(MainInformation.Category.dessert)
            })
                .pickerStyle(.menu)
                
            }
            .listRowBackground(listBackgroundColor)

            // альтернативная реализация picker
            /*
            Picker(selection: $mainInformation.category, label:
                        HStack {
                 Text("Category")
                 Spacer()
                 Text(mainInformation.category.rawValue)
             }) {
                 ForEach(MainInformation.Category.allCases, id: \.self) { category in
                 Text(category.rawValue)
                 }
             }
             .pickerStyle(MenuPickerStyle()) */

        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInfoTest = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
        ModifyMainInformationView(mainInformation: $mainInfoTest.mainInformation)
                .navigationTitle("Edit main info")
        }
    }
}
