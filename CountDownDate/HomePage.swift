//
//  HomePage.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/2.
//

import SwiftUI
import AVKit
import AVFoundation
import WidgetKit
import EventKit

struct HomePage: View {

    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("whichBigTest", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var whichBigTest: String = "TVE"
    @AppStorage("customeTargetDateSave1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave1: String = "2024/2/23"
    @AppStorage("customeTargetDateSave2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave2: String = "2024/4/03"
    @AppStorage("customeTargetDateSave3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave3: String = "2024/7/31"
    @AppStorage("customeWidgetName1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave1: String = "自訂1"
    @AppStorage("customeWidgetName2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave2: String = "自訂2"
    @AppStorage("customeWidgetName3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave3: String = "自訂3"
    @AppStorage("tutorial") var tutorialState: Bool = true
    
    @State var selectId: Int = 0
    @State var bigTestType: String = "TVE"
    @State var bigTestDate: Date = .now
    @State var showSheet: Bool = false
    @State var showCustomSheet: [Bool] = [false, false, false]
    
    @State var customeWidgetNameList: [String] = ["自訂1","自訂2","自訂3"]
//    @State var customeWidgetDateList: [String] = ["2024/2/23", "2024/4/03", "2024/7/31"]
    @State var customeWidgetDateList: [Date] = [DateComponents(calendar: .current, year: 2024, month: 2, day: 23).date!, DateComponents(calendar: .current, year: 2024, month: 4, day: 3).date!, DateComponents(calendar: .current, year: 2024, month: 7, day: 31).date!]
    
    let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
    let bigTestNameDict: [String:String] = ["CAP":"會考", "TVE":"統測", "GSAT":"學測"]
    let player = AVPlayer()
    
    var body: some View {
        NavigationStack(){
            VStack {
                GeometryReader { geo in
                    ScrollView(.vertical){
                        VStack(alignment:.leading) {
                            if tutorialState {
                                ZStack (alignment: .center) {
                                    TabView {
                                        Image("tutorial1")
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(20)
                                            .frame(height: 250)
                                        Image("tutorial2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 250)
                                            .cornerRadius(20)
                                    }
                                    .tabViewStyle(PageTabViewStyle())
                                    //                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                                    Button(action: {
                                        tutorialState.toggle()
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22)
                                            .foregroundStyle(Color.gray.opacity(0.4))
                                    }).padding(.leading, 325)
                                        .padding(.bottom, 210)
                                }.frame(height:250)
                            }
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
                                            .foregroundStyle(colorScheme == .light ? Color("samDeepBlue") : Color("aBayBackground"))
                                            .scrollTransition { content,phase in
                                                content.opacity(phase.isIdentity ? 1.0:0.0)
                                                    .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                            }
                                        WidgetPreviewRectangle(titleText: .constant(bigTestNameDict[bigTestType]!), targetDate: $bigTestDate)
                                            .background{
                                                Color("aBayBackground")
                                            }
                                            .cornerRadius(25)
                                            .frame(width: 160, height: 160)
                                            .shadow(color:Color.primary.opacity(0.4),radius: 8,x:4,y:4)
                                            .containerRelativeFrame(.horizontal, count:1, spacing:20)
                                            .scrollTransition { content,phase in
                                                content.opacity(phase.isIdentity ? 1.0:0.5)
                                                    .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                            }
                                        Spacer()
                                            .frame(height: 20)
                                        
                                        Button(action: {
                                            showSheet.toggle()
                                        }, label: {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 140, height: 50)
                                                    .background(Color("samDeepBlue"))
                                                    .cornerRadius(25)
                                                    .shadow(color:colorScheme == .light ?  Color("samDeepBlue").opacity(0.7) : Color(red: 0.4, green: 0.5, blue: 0.7).opacity(0.7), radius: 0, x: 0, y: 4)
                                                Text("編輯")
                                                    .font(.system(size: 26))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color.white)
                                            }.scrollTransition { content,phase in
                                                content.opacity(phase.isIdentity ? 1.0:0.0)
                                                    .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                            }
                                        }).sheet(isPresented: $showSheet) {
                                            EditBigTestDatePage(aleadySaveTestType: $bigTestType,aleadySaveTestDate: $bigTestDate)
                                                .presentationDetents([.medium, .large])
                                        }
                                    }
                                    ForEach(0..<3) { i in
                                        VStack{
                                            Text("自訂"+String(i+1))
                                                .font(.system(size: 24))
                                                .fontWeight(.semibold)
                                                .foregroundStyle(colorScheme == .light ? Color("samDeepBlue") : Color("aBayBackground"))
                                                .scrollTransition { content,phase in
                                                    content.opacity(phase.isIdentity ? 1.0:0.0)
                                                        .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                                }
                                                .frame(width:180)
                                            
                                            CustomizeWidgetPreviewRectangle(title: $customeWidgetNameList[i], targetDate: $customeWidgetDateList[i])
                                                .background{
                                                    Color("aBayBackground")
                                                }
                                                .cornerRadius(25)
                                                .frame(width: 160, height: 160)
                                                .shadow(color:Color.primary.opacity(0.4),radius: 8,x:4,y:4)
                                                .containerRelativeFrame(.horizontal, count:1, spacing:20)
                                                .scrollTransition { content,phase in
                                                    content.opacity(phase.isIdentity ? 1.0:0.5)
                                                        .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                                }
                                            
                                            Spacer()
                                                .frame(height: 20)
                                            Button(action: {
                                                showCustomSheet[i].toggle()
                                            }, label: {
                                                ZStack {
                                                    Rectangle()
                                                        .foregroundColor(.clear)
                                                        .frame(width: 140, height: 50)
                                                        .background(Color("samDeepBlue"))
                                                        .cornerRadius(25)
                                                        .shadow(color:colorScheme == .light ?  Color("samDeepBlue").opacity(0.7) : Color(red: 0.4, green: 0.5, blue: 0.7).opacity(0.7), radius: 0, x: 0, y: 4)
                                                    Text("編輯")
                                                        .font(.system(size: 26))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(Color.white)
                                                }.scrollTransition { content,phase in
                                                    content.opacity(phase.isIdentity ? 1.0:0.0)
                                                        .scaleEffect(phase.isIdentity ? 1.0:0.6)
                                                }
                                            }).sheet(isPresented: $showCustomSheet[i]) {
                                                EditDatePage(widgetNum: .constant(i+1), customeWidgetNameList: $customeWidgetNameList, customeWidgetDateList: $customeWidgetDateList)
                                                    .presentationDetents([.medium, .large])
                                            }
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
                    }
                    .frame(height: geo.size.height-1)
                    .background {
                        Color(Color("aBayBackground"))
                            .ignoresSafeArea()
                    }.toolbarBackground(
                        Color(red: 0.97, green: 0.92, blue: 0.88),
                        for: .navigationBar)
                    .toolbarBackground(
                        Color(red: 0.97, green: 0.92, blue: 0.88),
                        for: .bottomBar)
                }
            }.background {
                Color.gray.opacity(0.4).ignoresSafeArea()
            }

        }
        .onAppear{
            bigTestType = whichBigTest
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let testDay = dateFormatter.date(from: bigTestDateDict[bigTestType]!)
            bigTestDate = testDay!
            customeWidgetNameList[0] = customeWidgetNameSave1
            customeWidgetNameList[1] = customeWidgetNameSave2
            customeWidgetNameList[2] = customeWidgetNameSave3
            customeWidgetDateList[0] = dateFormatter.date(from: customeTargetDateSave1)!
            customeWidgetDateList[1] = dateFormatter.date(from: customeTargetDateSave2)!
            customeWidgetDateList[2] = dateFormatter.date(from: customeTargetDateSave3)!
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
                    Section(header: Text("請選擇大考類別"), footer: Text("請至主畫面或鎖定頁面新增此工具")) {
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
                        }
                    }
                    Section(header: Text("小工具進度條介紹")) {
                        VStack {
                            Image("graphDemo")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.orange, lineWidth: 2)
                                ).padding(.bottom, 10)
                            Text("此進度條能讓使用者用視覺化的方式看出距離目標剩餘多久，一行有12格分別由右至左對應月份。為考量排版至多顯示兩年內進度條。")
                        }
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
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("customeTargetDateSave1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave1: String = "2024/2/23"
    @AppStorage("customeTargetDateSave2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave2: String = "2024/4/03"
    @AppStorage("customeTargetDateSave3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave3: String = "2024/7/31"
    @AppStorage("customeWidgetName1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave1: String = "自訂1"
    @AppStorage("customeWidgetName2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave2: String = "自訂2"
    @AppStorage("customeWidgetName3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave3: String = "自訂3"
    @Binding var widgetNum: Int
    @Binding var customeWidgetNameList: [String]
    @Binding var customeWidgetDateList: [Date]
    
    @State var targetDate: Date = .now
    @State var customeWidgetName: String = "自訂"
    @State var outOfMaxLength: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    Section(header: Text("設定倒數標題")) {
                        HStack{
                            Image(systemName: "pencil.line")
                            TextField("請輸入倒數小工具標題", text: $customeWidgetName)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    Section(header: Text("設定目標日期"), footer: Text("請至主畫面新增此工具")) {
                        HStack(alignment:.center){
                            Image(systemName: "calendar")
                            DatePicker("目標日期", selection: $targetDate, in: Date()..., displayedComponents: .date)
                                .environment(\.locale,Locale.init(identifier: "zh-tw"))
                        }
                        
                    }
                    Section(header: Text("小工具進度條介紹")) {
                        VStack {
                            Image("graphDemo")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.orange, lineWidth: 2)
                                ).padding(.bottom, 10)
                            Text("此進度條能讓使用者用視覺化的方式看出距離目標剩餘多久，一行有12格分別由右至左對應月份。為考量排版至多顯示兩年內進度條。")
                        }
                    }
                }
                .onAppear{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    switch widgetNum {
                    case 1:
                        targetDate = dateFormatter.date(from: customeTargetDateSave1)!
                        customeWidgetName = customeWidgetNameSave1
                    case 2:
                        targetDate = dateFormatter.date(from: customeTargetDateSave2)!
                        customeWidgetName = customeWidgetNameSave2
                    case 3:
                        targetDate = dateFormatter.date(from: customeTargetDateSave3)!
                        customeWidgetName = customeWidgetNameSave3
                    default:
                        print("Error Rom Read")
                    }
                    
                }
                
            }
            .navigationTitle("小工具編輯")
                .toolbar {
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Button("儲存"){
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy/MM/dd"
                            let dateString = dateFormatter.string(from: targetDate)
                            if customeWidgetName.count > 5 {
                                outOfMaxLength = true
                            } else {
                                outOfMaxLength = false
                                self.presentationMode.wrappedValue.dismiss()
                                switch widgetNum {
                                case 1:
                                    customeTargetDateSave1 = dateString
                                    customeWidgetNameSave1 = customeWidgetName
                                    customeWidgetNameList[0] = customeWidgetName
                                    customeWidgetDateList[0] = targetDate
                                    WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateCustomizeWidget1")
                                case 2:
                                    customeTargetDateSave2 = dateString
                                    customeWidgetNameSave2 = customeWidgetName
                                    customeWidgetNameList[1] = customeWidgetName
                                    customeWidgetDateList[1] = targetDate
                                    WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateCustomizeWidget2")
                                case 3:
                                    customeTargetDateSave3 = dateString
                                    customeWidgetNameSave3 = customeWidgetName
                                    customeWidgetNameList[2] = customeWidgetName
                                    customeWidgetDateList[2] = targetDate
                                    WidgetCenter.shared.reloadTimelines(ofKind: "CountDownDateCustomizeWidget3")
                                default:
                                    print("Error Rom Save")
                                }
                            }
                            
                            
                            print("save-"+dateString+"to"+String(widgetNum))
                        }.alert("標題字數請勿超過五個字", isPresented: $outOfMaxLength) {
                            Button("重新編輯"){
                                
                            }
                        }
                    }
                }
        }
        
    }
}

struct WidgetPreviewRectangle: View {
    
    @Binding var titleText: String
        
    @Binding var targetDate: Date
    
    @State var downDays: Int = 100
    @State var isFinish: Bool = false
    @State var isToday: Bool = false
    
    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .center) {
                HStack(alignment: .bottom){
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(height: 29)
                    Text(titleText)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(width: 50, height: 30,alignment: .topLeading)
                        .padding(.leading,-5)
                    Text("倒數")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color("samDeepBlue").opacity(0.78))
                        .frame(width: 38, height: 23, alignment: .topLeading)
                        .padding(.leading,-8)
                }.padding(.top,0)
                
//                Spacer()
//                    .frame(height: 10)
                
                HStack(alignment: .firstTextBaseline){
                    Text(isToday ? "當":String(downDays))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color("samOrange"))
                        .frame(width: downDays>99||downDays < -99 ? 110:downDays>9||downDays<0 ? 80:50)
//                        .shadow(radius: 1,x:1,y:1)
                        .fontWeight(.heavy)
                    
                    Text("天")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(width: 18, height: 20, alignment: .topLeading)
                        .padding(.leading,-12)

                }.padding(.leading,8)
                    .padding(.top,-2)
                Spacer()
                    .frame(height:12)
                CountDownBarView(targetDate: $targetDate, isFinish: $isFinish)
                
            }.frame(width: geo.size.width,height: geo.size.height)
                .onAppear{
                    refreshVariable()
                    
                }
                .onChange(of: titleText) {
                    refreshVariable()
                }
            
//                .border(Color.black)
        }
        
    }
    
    func refreshVariable() {
        let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
        if targetDate <= .now {
            isFinish = true
            downDays = days.day!
        } else {
            isFinish = false
            downDays = days.day!+1
        }
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy/MM/dd"
        let targetDateCheck = dateForatter.string(from: targetDate)
        let todayCheck = dateForatter.string(from: .now)
        if targetDateCheck == todayCheck {
            isToday = true
        } else {
            isToday = false
        }
    }
}

struct CustomizeWidgetPreviewRectangle: View {
    
    @Binding var title: String
    @Binding var targetDate: Date
    
    @State var countDownNum: Int = 0
//    @State var targetDate: Date = .now
    @State var titleCount: Int = 0
    @State var isFinish: Bool = false
    @State var isToday: Bool = false

    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .center) {
                HStack(alignment: .bottom){
                    Image(systemName:isFinish ? "calendar.badge.checkmark":"calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(height: 29)
                    Text(title)
                        .font(.system(size:titleCount<4 ? 24 : 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(height: 30,alignment: .topLeading)
                        .padding(.leading,-5)
                    if titleCount<3 {
                        Text("倒數")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color("samDeepBlue").opacity(0.78))
                            .frame(width: 38, height: 23, alignment: .topLeading)
                            .padding(.leading,-8)
                    }
                }.padding(.top,0)
                
//                Spacer()
//                    .frame(height: 10)
                
                HStack(alignment: .firstTextBaseline){
                    Text(isToday ? "當":String(countDownNum))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color("samOrange"))
                        .frame(width: countDownNum>99||countDownNum < -99 ? 110:countDownNum>9||countDownNum<0 ? 80:50)
//                        .shadow(radius: 1,x:1,y:1)
                        .fontWeight(.heavy)
                    
                    Text("天")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color("samDeepBlue"))
                        .frame(width: 18, height: 20, alignment: .topLeading)
                        .padding(.leading,-8)

                }.padding(.leading,8)
                    .padding(.top,-2)
                Spacer()
                    .frame(height:10)
                CountDownBarView(targetDate: .constant(targetDate), isFinish: $isFinish)
                
            }.frame(width: geo.size.width,height: geo.size.height)
            
//                .border(Color.black)
        }.onAppear{
            refeshVariable()
        }
        .onChange(of: title) {
            refeshVariable()
        }
        .onChange(of: targetDate) {
            refeshVariable()
        }
    }
    
    func refeshVariable() {
        titleCount = title.count
        if targetDate <= .now {
            isFinish = true
            let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
            countDownNum = Int(days.day!)
        } else {
            isFinish = false
            let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
            countDownNum = Int(days.day!+1)
        }
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy/MM/dd"
        let targetDateCheck = dateForatter.string(from: targetDate)
        let todayCheck = dateForatter.string(from: .now)
        if targetDateCheck == todayCheck {
            isToday = true
        } else {
            isToday = false
        }
    }
}

#Preview {
    HomePage()
}

#Preview {
    EditBigTestDatePage(aleadySaveTestType: .constant("TVE"), aleadySaveTestDate: .constant(.now))
}

//#Preview {
//    EditBigTestDatePage(aleadySaveTestType: .constant("TVE"),aleadySaveTestDate: .constant(.now))
//}
//
//#Preview {
//    EditDatePage(widgetNum: .constant(1), customeWidgetNameList: .constant(["自訂one","自訂two","自訂three"]), customeWidgetDateList: .constant(["2023/12/20", "2023/12/20", "2023/12/20"]))
//}
