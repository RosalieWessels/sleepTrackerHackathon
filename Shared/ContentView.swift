//
//  ContentView.swift
//  Shared
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer( )                //LineView(data: [8,9,7,7.5,5,8,10], title: "My Sleep", legend: "Hours")
                let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.GradientNeonBlue, secondGradientColor: Colors.OrangeEnd, textColor: Color.white, legendTextColor: Color.white, dropShadowColor: Color.white)
    
                BarChartView(data: ChartData(values: [("Monday",8), ("Tuesday",7), ("Wednesday",6), ("Thursday",7.5), ("Today",9)]), title: "My Sleep Hours", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                Spacer()
                BarChartView(data: ChartData(values: [("Monday",8), ("Tuesday",7), ("Wednesday",6), ("Thursday",7.5), ("Today",9)]), title: "My Sleep Rating", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                Spacer()
            }.background(Image("background").resizable().scaledToFill().clipped())
            .edgesIgnoringSafeArea([.top])
            
            
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
