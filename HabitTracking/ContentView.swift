//
//  ContentView.swift
//  HabitTracking
//
//  Created by Gonzalo Gamez on 3/25/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
}

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items =
            UserDefaults.standard.data(forKey: "Items")
        {
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([Activity].self,
                               from:items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}


struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                        }
                        
                        
                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationBarTitle("Habit Tracker")
            
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddActivity = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddActivity) {
                    AddView(activities: self.activities)
            }

        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
