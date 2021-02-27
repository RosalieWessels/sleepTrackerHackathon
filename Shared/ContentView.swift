//
//  ContentView.swift
//  Shared
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            Text("This is our sleep tracker app!")
            
                .navigationBarTitle("Sleep Tracker App", displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: LogSleepView()) {
                    Text("Log Sleep")
                })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
