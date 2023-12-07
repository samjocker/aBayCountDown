//
//  CountDownDateCustomizeWidget.swift
//  CountDownDateCustomizeWidget
//
//  Created by 江祐鈞 on 2023/12/4.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("customeTargetDateSave1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave1: String = "2024/2/23"
    @AppStorage("customeTargetDateSave2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave2: String = "2024/4/03"
    @AppStorage("customeTargetDateSave3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeTargetDateSave3: String = "2024/7/31"
    @AppStorage("customeWidgetName1", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave1: String = "自訂1"
    @AppStorage("customeWidgetName2", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave2: String = "自訂2"
    @AppStorage("customeWidgetName3", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var customeWidgetNameSave3: String = "自訂3"

    
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), title: [customeWidgetNameSave1,customeWidgetNameSave2,customeWidgetNameSave3], targetDate: [getTargetDate(targetDateString: customeTargetDateSave1),getTargetDate(targetDateString: customeTargetDateSave2),getTargetDate(targetDateString: customeTargetDateSave3)], countDownNum: [getCountDownNum(targetDateString: customeTargetDateSave1), getCountDownNum(targetDateString: customeTargetDateSave2), getCountDownNum(targetDateString: customeTargetDateSave3)])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: [customeWidgetNameSave1,customeWidgetNameSave2,customeWidgetNameSave3], targetDate: [getTargetDate(targetDateString: customeTargetDateSave1),getTargetDate(targetDateString: customeTargetDateSave2),getTargetDate(targetDateString: customeTargetDateSave3)], countDownNum: [getCountDownNum(targetDateString: customeTargetDateSave1), getCountDownNum(targetDateString: customeTargetDateSave2), getCountDownNum(targetDateString: customeTargetDateSave3)])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, title: [customeWidgetNameSave1,customeWidgetNameSave2,customeWidgetNameSave3], targetDate: [getTargetDate(targetDateString: customeTargetDateSave1),getTargetDate(targetDateString: customeTargetDateSave2),getTargetDate(targetDateString: customeTargetDateSave3)], countDownNum: [getCountDownNum(targetDateString: customeTargetDateSave1), getCountDownNum(targetDateString: customeTargetDateSave2), getCountDownNum(targetDateString: customeTargetDateSave3)])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getTargetDate(targetDateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let testDay = dateFormatter.date(from: targetDateString)
        return testDay!
    }
    
    func getCountDownNum(targetDateString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let targetDate = dateFormatter.date(from: targetDateString)
        let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate!)
        return Int(days.day!+1)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
//    let emoji: String
    let title: [String]
    let targetDate: [Date]
    let countDownNum: [Int]
}

//struct CountDownDateCustomizeWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        CustomizeWidgetView(entry: entry, customizeNum: .constant(2))
//    }
//}

struct CountDownDateCustomizeWidget1: Widget {
    let kind: String = "CountDownDateCustomizeWidget1"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(1))
                    .containerBackground(Color(red: 0.95, green: 0.9, blue: 0.87), for: .widget)
            } else {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(1))
                    .padding()
                    .background(Color(red: 0.95, green: 0.9, blue: 0.87))
            }
        }
        .configurationDisplayName("自訂倒數小工具1")
        .description("放置屬於你的倒數小工具")
        .supportedFamilies([.systemSmall])
    }
}

struct CountDownDateCustomizeWidget2: Widget {
    let kind: String = "CountDownDateCustomizeWidget2"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(2))
                    .containerBackground(Color(red: 0.95, green: 0.9, blue: 0.87), for: .widget)
            } else {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(2))
                    .padding()
                    .background(Color(red: 0.95, green: 0.9, blue: 0.87))
            }
        }
        .configurationDisplayName("自訂倒數小工具2")
        .description("放置屬於你的倒數小工具")
        .supportedFamilies([.systemSmall])
    }
}

struct CountDownDateCustomizeWidget3: Widget {
    let kind: String = "CountDownDateCustomizeWidget3"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(3))
                    .containerBackground(Color(red: 0.95, green: 0.9, blue: 0.87), for: .widget)
            } else {
                CustomizeWidgetView(entry: entry, customizeNum: .constant(3))
                    .padding()
                    .background(Color(red: 0.95, green: 0.9, blue: 0.87))
            }
        }
        .configurationDisplayName("自訂倒數小工具3")
        .description("放置屬於你的倒數小工具")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    CountDownDateCustomizeWidget1()
} timeline: {
    SimpleEntry(date: .now, title: ["模擬考","模擬","模"], targetDate: [DateComponents(calendar: .current, year: 2024, month: 11, day: 10).date!, DateComponents(calendar: .current, year: 2024, month: 11, day: 10).date!, DateComponents(calendar: .current, year: 2024, month: 11, day: 10).date!], countDownNum: [140, 140, 140])
//    SimpleEntry(date: .now, title: "學測", targetDate: DateComponents(calendar: .current, year: 2024, month: 1, day: 20).date!, countDownNum: 48)
}

struct CustomizeWidgetView: View {
    var entry: Provider.Entry
    
    @Binding var customizeNum: Int
    
    @State var titleCount: Int = 0

    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .center) {
                HStack(alignment:titleCount<4 ? .bottom : .center){
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(height: 29)
                    Text(entry.title[customizeNum-1])
                        .font(.system(size:titleCount<4 ? 24 : 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(height: 30,alignment: .center)
                        .padding(.leading,-5)
                        .padding(.top, -3)
                    if titleCount<3 {
                        Text("倒數")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.78))
                            .frame(width: 38, height: 23, alignment: .topLeading)
                            .padding(.leading,-8)
                    }
                }.padding(.top,0)
                
//                Spacer()
//                    .frame(height: 10)
                
                HStack(alignment: .firstTextBaseline){
                    Text(String(entry.countDownNum[customizeNum-1]))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color(red: 1, green: 0.31, blue: 0.11))
                        .frame(width: entry.countDownNum[customizeNum-1]>99 ? 110:80)
//                        .shadow(radius: 1,x:1,y:1)
                        .fontWeight(.heavy)
                    
                    Text("天")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(width: 18, height: 20, alignment: .topLeading)
                        .padding(.leading,-8)

                }.padding(.leading,8)
                    .padding(.top,-2)
                Spacer()
                    .frame(height:10)
                CountDownBarView(targetDate: .constant(entry.targetDate[customizeNum-1]))
                
            }.frame(width: geo.size.width,height: geo.size.height)
            
//                .border(Color.black)
        }.onAppear{
            titleCount = entry.title[customizeNum-1].count
            print(customizeNum)
        }
        
    }
}

struct CountDownBarView: View {
    
    @Binding var targetDate: Date {
        didSet {
            leftDateYear1 = getCountDownNum(targetDate: targetDate, lineNum: 1)
            leftDateYear2 = getCountDownNum(targetDate: targetDate, lineNum: 2)
        }
    }
    @State var leftDateYear1: Int = 0
    @State var leftDateYear2: Int = 0
    @State var startDistYear1: Int = 0
    @State var startDistYear2: Int = 0
    @State var haveDoubleLine: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 120,height: leftDateYear2>0 ? 21:10)
                .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(4)
            Rectangle()
                .frame(width:CGFloat(120*(Float(leftDateYear2)/365.0)),height: 10)
                .foregroundStyle(Color.orange)
                .cornerRadius(4)
                .position(x:CGFloat(120*(Float(startDistYear2+leftDateYear2/2)/365.0)),y:5)
            Rectangle()
                .frame(width:CGFloat(120*(Float(leftDateYear1)/365.0)),height: 10)
                .foregroundStyle(Color.orange)
                .cornerRadius(4)
                .position(x:CGFloat(120*(Float(startDistYear1+leftDateYear1/2)/365.0)),y:haveDoubleLine ? 15.5 : 10)
            VStack(spacing:2){
                HStack(alignment: .top, spacing: 9) {
                    ForEach(0..<11){i in
                        Rectangle()
                            .frame(width: 1,height: 5)
                            .cornerRadius(1)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                if leftDateYear2 > 0 {
                    Rectangle()
                        .frame(width: 110,height: 1)
                        .cornerRadius(1)
                        .foregroundStyle(Color.gray)
                    HStack(alignment: .top, spacing: 9) {
                        ForEach(0..<11){i in
                            Rectangle()
                                .frame(width: 1,height: 5)
                                .cornerRadius(1)
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
            }
            VStack(alignment:.leading, spacing:0){
                Image(systemName: "flag.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:8)
                    .foregroundStyle(Color.red)
                    .padding(.leading,-0.3)
                Line()
                    .stroke(style: .init(dash: [2]))
                    .foregroundStyle(Color.red)
                    .frame(width:1, height:10)
                
            }.position(x:startDistYear2>0 ? CGFloat(120*(Float(startDistYear2)/365.0)+3.5):CGFloat(120*(Float(startDistYear1)/365.0)+3.5),y:startDistYear2>0 ? 0:5)
            
        }.frame(width: 120,height: leftDateYear2>0 ? 21:21)
        .onAppear{
            leftDateYear1 = getCountDownNum(targetDate: targetDate, lineNum: 1)
            leftDateYear2 = getCountDownNum(targetDate: targetDate, lineNum: 2)
            if leftDateYear2>0 {
                haveDoubleLine = true
            } else {
                haveDoubleLine = false
            }
            startDistYear1 = getStartDistNum(targetDate: targetDate, lineNum: 1, haveLine2: haveDoubleLine)
            startDistYear2 = getStartDistNum(targetDate: targetDate, lineNum: 2, haveLine2: haveDoubleLine)
//            print("------------")
//            print(leftDateYear1)
//            print(leftDateYear2)
//            print(startDistYear1)
//            print(startDistYear2)
        }
    }
    
    func getCountDownNum(targetDate: Date, lineNum: Int) -> Int {
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy"
        let dateYear = Int(dateForatter.string(from: targetDate))
        let nowYear = Int(dateForatter.string(from: .now))
        if nowYear == dateYear {
            if lineNum == 1 {
                let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate)
                return Int(days.day!)
            } else {
                return 0
            }
        } else if dateYear!-nowYear! == 1 {
            if lineNum == 1 {
                let endOfYear = DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!
                let days = Calendar.current.dateComponents([.day], from: .now, to: endOfYear)
                return Int(days.day!)
            } else if lineNum == 2 {
                let startOfYear = DateComponents(calendar: .current, year: dateYear, month:1, day: 1).date!
                let days = Calendar.current.dateComponents([.day], from: startOfYear, to: targetDate)
                return Int(days.day!)
            }
        }
        
        return 367
    }
    
    func getStartDistNum(targetDate: Date, lineNum: Int, haveLine2: Bool) -> Int {
        let dateForatter = DateFormatter()
        dateForatter.dateFormat = "yyyy"
        let dateYear = Int(dateForatter.string(from: targetDate))
        let nowYear = Int(dateForatter.string(from: .now))
        
        if haveLine2 {
            if lineNum == 1 {
//                let days = Calendar.current.dateComponents([.day], from: .now, to: DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!)
                return 0
            } else {
                let days = Calendar.current.dateComponents([.day], from: targetDate, to: DateComponents(calendar: .current, year: dateYear, month:12, day: 31).date!)
                return Int(days.day!)
            }
            
        } else {
            if lineNum == 1 {
                let days = Calendar.current.dateComponents([.day], from: targetDate, to: DateComponents(calendar: .current, year: nowYear, month:12, day: 31).date!)
                return Int(days.day!)
            } else {
                return 0
            }
            
        }
    }
}
//
//#Preview {
//    static var previews: some View {
//            let customDate = DateComponents(calendar: .current, year: 2024, month: 3, day: 4).date!
//
//            return CountDownBarView(targetDate: .constant(customDate))
//                .environment(\.locale, Locale(identifier: "en_US"))
//        }
//
////    CountDownBarView(targetDate: .constant(.now))
//}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

//struct DemoView_Previews: PreviewProvider {
//    static var previews: some View {
//            let customDate = DateComponents(calendar: .current, year: 2024, month:12, day: 27).date!
//            
//            return CountDownBarView(targetDate: .constant(customDate))
//        }
//}
