//
//  LogSleepView.swift
//  sleepTrackerHackathon
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI
import Firebase

struct LogSleepView: View {
    
    @State var db = Firestore.firestore()
    @Environment(\.presentationMode) var presentationMode
    
    @State var screenWidth = UIScreen.main.bounds.size.width
    
    @State var logDay = Date()
    @State var hoursSlept: String = ""
    @State var rating: Int?
    @State var notes: String = ""
    
    var body: some View {
    
        VStack {
            
            Text("Log Sleep")
                .navigationBarTitle("Log Sleep", displayMode: .inline)
                .padding(10)
                .font(Font.custom("Menlo-Bold", size: 35))
                .foregroundColor(.white)
            
            VStack {
                DatePicker("What day are you logging?", selection: $logDay, in: ...Date(), displayedComponents: .date)
                    .padding(.horizontal, 10)
                    .font(Font.custom("Menlo-Bold", size: 13))
                    .frame(width: 260, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                
                HStack {
                    Text("How long did you sleep for?")
                    
                    TextField("  ", text:$hoursSlept)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 28, height: 25)
                }
                .font(Font.custom("Menlo-Bold", size: 13))
                .frame(width: 260, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                
                VStack {
                    Text("How would you rate your sleep?")
                        .padding(.bottom, 10)
                    
                    RatingView(rating: $rating, max: 5)
                }
                .font(Font.custom("Menlo-Bold", size: 13))
                .frame(width: 260, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                
                ZStack {
                    Rectangle()
                        .frame(width: 260, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(1)
                    TextField("Notes...", text:$notes)
                        .font(Font.custom("Menlo-Italic", size: 10))
                        .frame(width: 230, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(0.5)
                
//                NavigationLink(destination: ContentView()) {
//                    ZStack {
//                        Rectangle()
//                            .frame(width: 70, height: 25)
//                            .cornerRadius(10)
//                            .shadow(radius: 20)
//                            .foregroundColor(Color.white.opacity(0.8))
//                        Text("Submit")
//                            .foregroundColor(Color(.black))
//                            .font(Font.custom("Menlo-Bold", size: 15))
//                    }
//                }.simultaneousGesture(TapGesture().onEnded{
//                    submitButtonPressed()
//                })
//                .padding(.top, 20)
                
                Button(action: submitButtonPressed) {
                    ZStack {
                        Rectangle()
                            .frame(width: 70, height: 25)
                            .cornerRadius(10)
                            .shadow(radius: 20)
                            .foregroundColor(Color.white.opacity(0.8))
                        Text("Submit")
                            .foregroundColor(Color(.black))
                            .font(Font.custom("Menlo-Bold", size: 15))
                    }
                }
                .padding(.top, 20)
            }
                
            }
        .background(Image("moonBackground")
                        .scaledToFill())
        }
    
        func submitButtonPressed() {
            //let myTimeStamp = logDay.timeIntervalSince1970
            
            
            db.collection("TestPerson").document().setData([
                "Date": logDay,
                "DateString": "2/27",
                "SleepHours": Double(hoursSlept),
                "SleepRating": Int(rating!),
                "Notes": notes
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    
        
    }

struct RatingView: View {
    
    // star animation credit: https://azamsharp.medium.com/building-a-rating-view-in-swiftui-c76468d2be6
    
    @Binding var rating: Int?
    @State var max: Int = 5
    
    func starType(index: Int) -> String {
        if let rating = self.rating {
            return index <= rating ? "star.fill" : "star"
        } else {
            return "star"
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<(max + 1), id: \.self) { index in
                Image(systemName: self.starType(index: index))
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        self.rating = index
                    }
            }
        }
    }
    
}


struct LogSleepView_Previews: PreviewProvider {
    static var previews: some View {
        LogSleepView()
            .padding(0.0)
    }
}
