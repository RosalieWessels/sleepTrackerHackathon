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
    
    @State var daysData = [String]()
    @State var sleepData = [Double]()
    @State var ratingData = [Int]()
    @State var noteData = [String]()
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 30){
                    //Spacer( )
                    let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.GradientNeonBlue, secondGradientColor: Colors.OrangeEnd, textColor: Color.white, legendTextColor: Color.black, dropShadowColor: Color.black)
                    
                    if chartData[0] != ("Test", 10.0) {
                        BarChartView(data: ChartData(values: chartData), title: "My Sleep Hours", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                    }

    //                Spacer()
                    if ratingsData[0] != ("Test", 10) {
                        BarChartView(data: ChartData(values: ratingsData), title: "My Sleep Rating", legend: "Per day", style: chartStyle, form: ChartForm.extraLarge)
                    }
    //                Spacer()
                    if daysData.count >= 1{
                        detailsOfSleepView(dateName: String(daysData[0]), sleepHours: Double(sleepData[0]), rating: Int(ratingData[0]), note: String(noteData[0]))
                    }
                    
                    if daysData.count >= 2{
                        detailsOfSleepView(dateName: String(daysData[1]), sleepHours: Double(sleepData[1]), rating: Int(ratingData[1]), note: String(noteData[1]))
                    }
                    
                    if daysData.count >= 3{
                        detailsOfSleepView(dateName: String(daysData[2]), sleepHours: Double(sleepData[2]), rating: Int(ratingData[2]), note: String(noteData[2]))
                    }
                    
                    if daysData.count >= 4{
                        detailsOfSleepView(dateName: String(daysData[3]), sleepHours: Double(sleepData[3]), rating: Int(ratingData[3]), note: String(noteData[3]))
                    }
                    
                    if daysData.count >= 5{
                        detailsOfSleepView(dateName: String(daysData[4]), sleepHours: Double(sleepData[4]), rating: Int(ratingData[4]), note: String(noteData[4]))
                    }




                }
                .padding(.top, 20)
            }
            .padding()
            .background(Image("background").resizable().scaledToFill().clipped())
            .edgesIgnoringSafeArea([.bottom])
            
            
            .navigationBarTitle("Sleep Tracker App", displayMode: .inline)
            .navigationBarItems(leading: NavigationLink(destination: AmbientSoundsView()) {
                Text("Sounds")
            }, trailing: NavigationLink(destination: LogSleepView()) {
                Text("Log Sleep")
            })
            .onAppear(perform: {
                getDataForCharts()
                getDataForIndividualBoxes()
            })
        }
        
    }
    

    
    func getDataForCharts() {
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
                                    chartData.reverse()
                                }
                                
                                if let rating = document.get("SleepRating") as? Int {
                                    ratingsData.append(("\(sleepDate)", rating))
                                    
                                    print(ratingsData)
                                    
                                    if ratingsData.count == 6 && ratingsData[0] == ("Test", 10) {
                                        ratingsData.remove(at: 0)
                                        ratingsData.reverse()
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
                                    chartData.reverse()
                                }
                                
                                if let rating = document.get("SleepRating") as? Int {
                                    ratingsData.append(("\(sleepDate)", rating))
                                    
                                    print(ratingsData)
                                    
                                    if ratingsData.count == 6 && ratingsData[0] == ("Test", 10) {
                                        ratingsData.remove(at: 0)
                                        ratingsData.reverse()
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func getDataForIndividualBoxes() {
        daysData = [String]()
        sleepData = [Double]()
        ratingData = [Int]()
        noteData = [String]()
        db.collection("TestPerson").order(by: "Date", descending: true).limit(to: 5).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let date = document.get("Date") {
                        if let dateString = document.get("DateString") {
                            if let sleepHours = document.get("SleepHours") {
                                if let sleepRating = document.get("SleepRating") {
                                    if let note = document.get("Notes") {
                                        daysData.append(dateString as! String)
                                        sleepData.append(sleepHours as! Double)
                                        ratingData.append(sleepRating as! Int)
                                        noteData.append(note as! String)
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

struct detailsOfSleepView: View {
    
    @State var dateName : String
    @State var sleepHours : Double
    @State var rating : Int
    @State var note : String
    
    var body: some View {
        VStack {
            HStack {
                Text("My Sleep on \(dateName)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                Spacer()
                
            }
            .padding(.vertical, 10)
            HStack {
                Text("Hours: \(String(format: "%.1f", sleepHours))")
                    .foregroundColor(.white)
                    .font(.callout)
                Spacer()
                Text("Rating: \(rating)")
                    .foregroundColor(.white)
                    .font(.callout)
                Spacer()
            }
            .padding(.vertical, 10)
            HStack {
                Text("Note: \(note)")
                    .foregroundColor(.white)
                    .font(.callout)
                Spacer()
            }
            .padding(.vertical, 10)
            
        }
        .padding()
        .background(Color.black)
        .cornerRadius(20)
    }
}
