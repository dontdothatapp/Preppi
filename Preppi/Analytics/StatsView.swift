//
//  AnalyticsView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct StatsView: View {
    
    @State var progressValueBehavioral: Float = 0.0
    @State var totalQuestions: Int = 0
    @State var totalMastered: Int = 0
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var questionModel: QuestionModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                //Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        //Overall progress card
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 210)
                                .foregroundColor(.additional_50)
                                .cornerRadius(30)
                                .padding(.top, 24)
                                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                            
                            VStack{
                                
                                //Title
                                HStack {
                                    Text("Your overall progress")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_700)
                                        .font(.system(size: 17))
                                        .fontWeight(.light)
                                    Spacer()
                                }
                                
                                //Line divider
                                HStack {
                                    Rectangle()
                                        .padding(.leading, 40)
                                        .frame(width: 250, height: 0.5)
                                        .foregroundColor(.text_50)
                                    Spacer()
                                }
                                
                                //Overall progress
                                HStack{
                                    
                                    //Circle progress
                                    VStack {
                                        ZStack {
                                            
                                            Circle()
                                                .stroke(lineWidth: 8)
                                                .foregroundColor(.primary_50)
                                                .opacity(0.2)
                                                .frame(maxWidth: 60)
                                            
                                            Circle()
                                                .trim(from: 0, to: Double(totalMastered)/Double(totalQuestions))
                                                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                                .foregroundColor(.primary_900)
                                                .rotation3DEffect(Angle(degrees: 270), axis: (x: 0, y: 0, z: 1))
                                                .frame(maxWidth: 60)
                                        }
                                    }
                                    
                                    //Data progress
                                    VStack (alignment: .leading) {
                                        //Text("29% mastered")
                                        Text("\(totalMastered) mastered")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 34))
                                            .fontWeight(.bold)
                                        //Text("+4% last week")
                                        Text("\(totalQuestions) total")
                                            .foregroundColor(.text_700)
                                            .font(.system(size: 22))
                                            .fontWeight(.regular)
                                    } .padding(.leading, 20)
                                    Spacer()
                                } .padding(.leading, 40)
                            }
                        }
                        
                        
                        ForEach(questionModel.statsForMasteredQuestions) { item in
                                ProgressCircleView(category: item.category, mastered: item.mastered, total: item.total)
                        } .onAppear() {
                            self.totalQuestions = questionModel.statsForMasteredQuestions.reduce(0) { $0 + $1.total }
                            self.totalMastered = questionModel.statsForMasteredQuestions.reduce(0) { $0 + $1.mastered }
                        } .frame(height: 100)
                    } .padding(.bottom, 20)
                } .onAppear(perform: fetchMasteredQuestions)
            }
            .navigationTitle("Progress")
        }
    }
    
    func fetchMasteredQuestions() {
        questionModel.getStatsObjects(masteredQuestions: questionModel.masteredQuestions) { (masteredQQuestions) in
            questionModel.statsForMasteredQuestions = masteredQQuestions
        }
    }
    
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(QuestionManager())
            .environmentObject(QuestionModel())
    }
}
