//
//  HomePage.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/2.
//

import SwiftUI
import WidgetKit

struct HomePage: View {
    
    @State var selectId: Int = 0
    @State var bigTestType: String = "CAP"
    @State var bigTestDate: Date = .now
    @AppStorage("whichBigTest", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var whichBigTest: String = "GSAT"
    let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
    let bigTestNameDict: [String:String] = ["CAP":"會考", "TVE":"統測", "GSAT":"學測"]
    
    var body: some View {
        NavigationStack(){
            ScrollView(.vertical){
                VStack(alignment:.leading) {
                    Text("小工具編輯")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(alignment:.center){
                            VStack{
                                Text("會考/學測/統測")
                                    .font(.system(size: 26))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                    .scrollTransition { content,phase in
                                        content.opacity(phase.isIdentity ? 1.0:0.0)
                                            .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                    }
                                
                                WidgetPreviewRectangle(titleText: .constant(bigTestNameDict[bigTestType]!), targetDate: $bigTestDate)
                                    .background{
                                        Color(red: 0.95, green: 0.9, blue: 0.87)
                                    }
                                    .cornerRadius(25)
                                    .frame(width: 160, height: 160)
                                    .shadow(radius: 8,x:4,y:4)
                                    .containerRelativeFrame(.horizontal, count:1, spacing:20)
                                    .scrollTransition { content,phase in
                                        content.opacity(phase.isIdentity ? 1.0:0.5)
                                            .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                    }
                                Spacer()
                                    .frame(height: 20)
                                NavigationLink() {
                                    EditBigTestDatePage(aleadySaveTestType: $bigTestType,aleadySaveTestDate: $bigTestDate)
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 140, height: 50)
                                            .background(Color(red: 0.2, green: 0.3, blue: 0.5))
                                            .cornerRadius(25)
                                            .shadow(color: Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.7), radius: 0, x: 0, y: 4)
                                        Text("編輯")
                                            .font(.system(size: 26))
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.white)
                                    }.scrollTransition { content,phase in
                                        content.opacity(phase.isIdentity ? 1.0:0.0)
                                            .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                    }
                                }.padding(.bottom,5)
                            }
                            ForEach(0..<3) { i in
                                VStack{
                                    Text("自定"+String(i+1))
                                        .font(.system(size: 24))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(red: 0.2, green: 0.3, blue: 0.5))
                                        .scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.0)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                        .frame(width:160)
                                    
                                    Rectangle()
                                        .frame(width: 160,height: 160)
                                        .cornerRadius(25)
                                        .foregroundStyle(Color.orange)
                                        .containerRelativeFrame(.horizontal, count:1, spacing:20)
                                        .shadow(radius: 8,x:4,y:4)
                                        .id(i)
                                        .scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.5)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                    Spacer()
                                        .frame(height: 10)
                                    NavigationLink() {
                                        EditDatePage()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 160, height: 50)
                                                .background(Color(red: 0.2, green: 0.3, blue: 0.5))
                                                .cornerRadius(25)
                                                .shadow(color: Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.7), radius: 0, x: 0, y: 4)
                                            Text("編輯")
                                                .font(.system(size: 26))
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.white)
                                        }.scrollTransition { content,phase in
                                            content.opacity(phase.isIdentity ? 1.0:0.0)
                                                .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                        }
                                    }.padding(.bottom,5)
                                }
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.bottom,14)
                        
                    }
                    .contentMargins(100)
                    .scrollTargetBehavior(.viewAligned)
                    .frame(height:350)
//                    .background(Color.white)
                }
                .navigationTitle("初四倒數")
                
//                    .toolbarBackground(Color(red: 0.95, green: 0.9, blue: 0.87).opacity(0.5), for: .navigationBar)
            }.background {
                Color(red: 0.95, green: 0.95, blue: 0.97)
                    .ignoresSafeArea()
            }

        }.onAppear{
            bigTestType = whichBigTest
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let testDay = dateFormatter.date(from: bigTestDateDict[bigTestType]!)
            bigTestDate = testDay!
        }
        
    }
    
}

struct EditBigTestDatePage: View {
    
    @State var bigTestType: String = "TVE"
    @Binding var aleadySaveTestType: String
    @Binding var aleadySaveTestDate: Date
    // CAP:會考,TVE:統測,GSAT:學測
    @AppStorage("whichBigTest", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var whichBigTest = "TVE"
    let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    Section(header: Text("請選擇大考類別")) {
                        HStack(alignment:.center){
                            Image(systemName: "doc.append")
                            Text("大考類別")
                            Spacer()
                                .frame(width: 40)
                            Picker("大考類別",selection: $bigTestType){
                                Text("會考").tag("CAP")
                                Text("學測").tag("GSAT")
                                Text("統測").tag("TVE")
                            }.pickerStyle(.segmented)
                        }.onAppear{
                            bigTestType = whichBigTest
                            aleadySaveTestType = whichBigTest
                            print(bigTestType)
                        }
                    }
                    Button("testButton"){
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy/MM/dd"
                        let testDay = dateFormatter.date(from: bigTestDateDict[bigTestType]!)
                        let days = Calendar.current.dateComponents([.day], from: .now, to: testDay!)
                        print(String(days.day!+1))
                    }
                }
                
            }.navigationTitle("小工具編輯")
                .toolbar {
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Button("儲存"){
                            self.presentationMode.wrappedValue.dismiss()
                            whichBigTest = bigTestType
                            aleadySaveTestType = bigTestType
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy/MM/dd"
                            let testDay = dateFormatter.date(from: bigTestDateDict[bigTestType]!)
                            aleadySaveTestDate = testDay!
                            WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateWidget")
                            print("save-"+bigTestType)
                        }
                    }
                }
        }
    }
}

struct EditDatePage: View {
    
    @State var targetDate: Date = .now
    @AppStorage("targetDateSave") var targetDateSave: String = "2023/12/03"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    Section(header: Text("設定目標日期")) {
                        HStack(alignment:.center){
                            Image(systemName: "calendar")
                            DatePicker("目標日期", selection: $targetDate, in: Date()..., displayedComponents: .date)
                                .environment(\.locale,Locale.init(identifier: "zh-tw"))
                        }
                        
                    }
                    Button("testButton"){
                        let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
                        print(String(days.day!+1))
                    }
                }.onAppear{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    targetDate = dateFormatter.date(from: targetDateSave)!
                }
                
            }.navigationTitle("小工具編輯")
                .toolbar {
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Button("儲存"){
                            self.presentationMode.wrappedValue.dismiss()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy/MM/dd"
                            let dateString = dateFormatter.string(from: targetDate)
                            targetDateSave = dateString
                            print("save-"+dateString)
                        }
                    }
                }
        }
        
    }
}

struct WidgetPreviewRectangle: View {
    
    @Binding var titleText: String
    @Binding var targetDate: Date
    @State var downDays:Int = 100
    
    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .center) {
                HStack(alignment: .bottom){
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(height: 29)
                    Text(titleText)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(width: 50, height: 30,alignment: .topLeading)
                        .padding(.leading,-5)
                    Text("倒數")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.78))
                        .frame(width: 38, height: 23, alignment: .topLeading)
                        .padding(.leading,-8)
                }.padding(.top,0)
                
//                Spacer()
//                    .frame(height: 10)
                
                HStack(alignment: .firstTextBaseline){
                    Text(String(downDays))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color(red: 1, green: 0.31, blue: 0.11))
                        .frame(width: downDays>99 ? 100:84)
//                        .shadow(radius: 1,x:1,y:1)
                        .fontWeight(.heavy)
                    
                    Text("天")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(width: 18, height: 20, alignment: .topLeading)
                        .padding(.leading,-12)

                }.padding(.leading,8)
                    .padding(.top,-2)
                Spacer()
                    .frame(height:12)
                CountDownBarView(targetDate: $targetDate)
                
            }.frame(width: geo.size.width,height: geo.size.height)
                .onAppear{
                    let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
                    print(String(days.day!+1))
                    downDays = days.day!+1
                }
            
//                .border(Color.black)
        }
        
    }
}

#Preview {
    HomePage()
}

#Preview {
    EditBigTestDatePage(aleadySaveTestType: .constant("TVE"),aleadySaveTestDate: .constant(.now))
}

#Preview {
    EditDatePage()
}
