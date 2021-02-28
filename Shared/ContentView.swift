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
    @State var chartData = [("Test", 10.0)]
    @State var ratingsData = [("Test", 10)]
    
        
    var body: some View {
        NavigationView {
            VStack {
                Spacer( )
                let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.GradientNeonBlue, secondGradientColor: Colors.OrangeEnd, textColor: Color.white, legendTextColor: Color.black, dropShadowColor: Color.white)
                
                if chartData[0] != ("Test", 10.0) {
                    BarChartView(data: ChartData(values: chartData), title: "My Sleep Hours", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                }

                Spacer()
                if ratingsData[0] != ("Test", 10) {
                    BarChartView(data: ChartData(values: ratingsData), title: "My Sleep Rating", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                }
                Spacer()
                Text("This is our sleep tracker app!")
            }
            .background(Image("background").resizable().scaledToFill().clipped())
            .edgesIgnoringSafeArea([.top])
            
            
            .navigationBarTitle("Sleep Tracker App", displayMode: .inline)
            .navigationBarItems(leading: NavigationLink(destination: AmbientSoundsView()) {
                Text("Sounds")
            }, trailing: NavigationLink(destination: LogSleepView()) {
                Text("Log Sleep")
            })
            .onAppear(perform: getData)
        }
        
    }
    

    
    func getData() {
        if chartData[0] == ("Test", 10.0) && ratingsData[0] == ("Test", 10){
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
                                }
                                
                                if let rating = document.get("SleepRating") as? Int {
                                    ratingsData.append(("\(sleepDate)", rating))
                                    
                                    print(ratingsData)
                                    
                                    if ratingsData.count == 6 && ratingsData[0] == ("Test", 10) {
                                        ratingsData.remove(at: 0)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                }
            }
        } else {
            chartData = [("Test", 10.0)]
            ratingsData = [("Test", 10)]
            
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
                                }
                                
                                if let rating = document.get("SleepRating") as? Int {
                                    ratingsData.append(("\(sleepDate)", rating))
                                    
                                    print(ratingsData)
                                    
                                    if ratingsData.count == 6 && ratingsData[0] == ("Test", 10) {
                                        ratingsData.remove(at: 0)
                                    }
                                }
                            }
                            
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
