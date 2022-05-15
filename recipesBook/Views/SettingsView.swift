//
//  SettingsView.swift
//  recipesBook
//
//  Created by Антон Голубейков on 15.05.2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var hideOptionalSteps: Bool = false
    @State private var listBackgroundColor = AppColor.background
    @State private var listTextColor = AppColor.foreground
        
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("TextColor", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
