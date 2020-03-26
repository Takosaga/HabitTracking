//
//  AddView.swift
//  HabitTracking
//
//  Created by Gonzalo Gamez on 3/25/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var descripition = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                
                TextField("Description", text: $descripition)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing:
                Button("Save") {
                    
                        let item = Activity(name:
                            self.name, description: self.descripition)
                        self.activities.items.append(item)
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
            )
                
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
