//
//  CountDownDateWidget.swift
//  CountDownDateWidget
//
//  Created by 江祐鈞 on 2023/11/29.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "統測", downDate: 147)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "學測", downDate: 147)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, title: "統測", downDate: 147)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let downDate: Int
}

struct CountDownDateWidgetEntryView : View {
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
                }.padding(.top,-12)
                
                Spacer()
                    .frame(height: 10)
                
                HStack(alignment: .firstTextBaseline){
                    Text(String(entry.downDate))
                        .font(.system(size: 50, design: .rounded))
                        .foregroundColor(Color(red: 1, green: 0.31, blue: 0.11))
                        .frame(width: entry.downDate>99 ? 100:84)
//                        .shadow(radius: 1,x:1,y:1)
                        .fontWeight(.heavy)
                    
                    Text("天")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        .frame(width: 18, height: 20, alignment: .topLeading)
                        .padding(.leading,-12)

                }.padding(.leading,8)
                
            }.frame(width: geo.size.width,height: geo.size.height)
            
//                .border(Color.black)
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
                    .background()
            }
        }
        .configurationDisplayName("學測倒數")
        .description("顯示距離學測考試剩餘幾天")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    CountDownDateWidget()
} timeline: {
    SimpleEntry(date: .now, title: "統測", downDate: 147)
    SimpleEntry(date: .now, title: "學測", downDate: 48)
}
