//
//  CountDownDateWidget.swift
//  CountDownDateWidget
//
//  Created by 江祐鈞 on 2023/11/29.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("whichBigTest", store: UserDefaults(suiteName: "group.Sam.CountDownDate")) var whichBigTest: String = "GSAT"
    let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
    let bigTestNameDict: [String:String] = ["CAP":"會考", "TVE":"統測", "GSAT":"學測"]
//    @State var targetDate: Date = .now
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), title: bigTestNameDict[whichBigTest]!, targetDate: getTargetDate(bigTestName: whichBigTest), countDownNum: getCountDownNum(bigTestName: whichBigTest))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: bigTestNameDict[whichBigTest]!, targetDate: getTargetDate(bigTestName: whichBigTest), countDownNum: getCountDownNum(bigTestName: whichBigTest))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, title: bigTestNameDict[whichBigTest]!, targetDate: getTargetDate(bigTestName: whichBigTest), countDownNum: getCountDownNum(bigTestName: whichBigTest))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getTargetDate(bigTestName: String) -> Date {
        let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let testDay = dateFormatter.date(from: bigTestDateDict[bigTestName]!)
        return testDay!
    }
    
    func getCountDownNum(bigTestName: String) -> Int {
        let bigTestDateDict: [String:String] = ["CAP":"2024/05/18", "TVE":"2024/04/27", "GSAT":"2024/01/20"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let targetDate = dateFormatter.date(from: bigTestDateDict[bigTestName]!)
        let days = Calendar.current.dateComponents([.day], from: .now, to: targetDate!)
        return Int(days.day!+1)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let targetDate: Date
    let countDownNum: Int
}

struct CountDownDateWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
            case .systemSmall :
                    smallCountDownDateWidget(entry: entry)
            case .accessoryCircular :
            ZStack{
                AccessoryWidgetBackground()
                VStack(spacing: 1) {
                    Text(entry.title)
                        .font(.system(size: 14,design: .rounded))
                        .fontWeight(.medium)
                    //                    Spacer()
                    //                        .frame(height:2)
                    Rectangle()
                        .frame(width: 50,height: 1)
                    //                    Spacer()
                    //                        .frame(height:6)
                    Text(String(entry.countDownNum))
                        .font(.system(size: 22,design: .rounded))
                        .fontWeight(.bold)
                }
            }
        case .accessoryInline :
            HStack{
                Image(systemName: "calendar.badge.clock")
                Text(entry.title+" 倒數"+String(entry.countDownNum)+"天")
            }
                
            default:
                Text("Error")
        }
        
        
    }
    
    
}

struct CountDownDateWidget: Widget {
    let kind: String = "CountDownDateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CountDownDateWidgetEntryView(entry: entry)
                    .containerBackground(Color(red: 0.95, green: 0.9, blue: 0.87), for: .widget)
            } else {
                CountDownDateWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(red: 0.95, green: 0.9, blue: 0.87))
            }
        }
        .configurationDisplayName("大考倒數")
        .description("顯示距離大考剩餘幾天")
        .supportedFamilies([.systemSmall, .accessoryCircular, .accessoryInline])
    }
}

struct smallCountDownDateWidget: View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .center) {
                HStack(alignment: .bottom){
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(height: 29)
                    Text(entry.title)
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
                    Text(String(entry.countDownNum))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color(red: 1, green: 0.31, blue: 0.11))
                        .frame(width: entry.countDownNum>99 ? 100:80)
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
                CountDownBarView(targetDate: .constant(entry.targetDate))
                
            }.frame(width: geo.size.width,height: geo.size.height)
            
//                .border(Color.black)
        }
        
    }
}

#Preview(as: .systemSmall) {
    CountDownDateWidget()
} timeline: {
    SimpleEntry(date: .now, title: "統測", targetDate: DateComponents(calendar: .current, year: 2024, month: 11, day: 10).date!, countDownNum: 140)
    SimpleEntry(date: .now, title: "學測", targetDate: DateComponents(calendar: .current, year: 2024, month: 1, day: 20).date!, countDownNum: 48)
}
