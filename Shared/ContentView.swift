//
//  ContentView.swift
//  Shared
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI
import SwiftUICharts
import Firebase

struct ContentView: View {
    
    //var db: Firestore!
    @State var db = Firestore.firestore()
    
    @State var sleepHourOne = 2
    @State var sleepHoursData : [Double] = [2.0, 8.0, 7.5, 9.5, 10]
    @State var chartData = [("Test", 10.0)]
    
        
    var body: some View {
        NavigationView {
            VStack {
                //LineView(data: [8,9,7,7.5,5,8,10], title: "My Sleep", legend: "Hours")
                if chartData[0] != ("Test", 10.0) {
                    BarChartView(data: ChartData(values: chartData), title: "My Sleep Hours", legend: "Per day", form: ChartForm.extraLarge)
                }
                Text("This is our sleep tracker app!")
                Button(action: {
                    getData()
                }) {
                    Text("click")
                }
                
            }
            
            .navigationBarTitle("Sleep Tracker App", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: LogSleepView()) {
                Text("Log Sleep")
            })
            .onAppear(perform: getData)
        }
        
    }
    

    
    func getData() {
        db.collection("TestPerson").order(by: "Date", descending: true).limit(to: 5).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let sleepHours = document.get("SleepHours") as? Double {
                        print("SleepHours", sleepHours)
                        if let sleepDate = document.get("DateString") as? String {
                            
                            chartData.append(("\(sleepDate)", Double(sleepHours)))
                            
                            print(chartData)
                            
                            if chartData.count == 6 && chartData[0] == ("Test", 10.0) {
                                chartData.remove(at: 0)
                                print("yes")
                            }
                        }
                        else {
                            print("Hello")
                        }
                        
                    }
                }
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
