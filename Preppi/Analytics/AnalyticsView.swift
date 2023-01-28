//
//  AnalyticsView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct AnalyticsView: View {
    
    @State var progressValueOverall: Float = 0.0
    @State var progressValueBehavioral: Float = 0.0
    @State var progressValueProductDesign: Float = 0.0
    @State var progressValueProductStrategy: Float = 0.0
    @State var progressValueExecution: Float = 0.0
    @State var progressValueAnalytical: Float = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                //Content
                ScrollView {
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 210)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 4)
                            
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
                                        ProgressBarView(progress: self.$progressValueOverall)
                                            .frame(width: 48).onAppear() {
                                                self.progressValueOverall = 0.3
                                            }
                                    }
                                    
                                    //Data progress
                                    VStack (alignment: .leading) {
                                        Text("29% mastered")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 34))
                                            .fontWeight(.bold)
                                        Text("+4% last week")
                                            .foregroundColor(.text_700)
                                            .font(.system(size: 22))
                                            .fontWeight(.regular)
                                    }
                                }
                            }
                        }
                        
                        //behavioral blcok
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 90)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 4)
                            
                            VStack {
                                HStack{
                                    Text("behavioral")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_900)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        ProgressBarView(progress: self.$progressValueBehavioral)
                                            .frame(width: 56).onAppear() {
                                                self.progressValueBehavioral = 0.72
                                            }
                                        Text("72%")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.trailing, 40)
                                }
                                .padding(.top, 16)
                            }
                        } .frame(height: 90)
                        
                        //product design block
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 90)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                            
                            VStack {
                                HStack{
                                    Text("product design")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_900)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        ProgressBarView(progress: self.$progressValueProductDesign)
                                            .frame(width: 56).onAppear() {
                                                self.progressValueProductDesign = 0.16
                                            }
                                        Text("16%")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.trailing, 40)
                                }
                                .padding(.top, 16)
                            }
                        } .frame(height: 90) .padding(.top, 10)
                        
                        //product strategy block
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 90)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                            
                            VStack {
                                HStack{
                                    Text("product strategy")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_900)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        ProgressBarView(progress: self.$progressValueProductStrategy)
                                            .frame(width: 56).onAppear() {
                                                self.progressValueProductStrategy = 0.39
                                            }
                                        Text("39%")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.trailing, 40)
                                }
                                .padding(.top, 16)
                            }
                        } .frame(height: 90) .padding(.top, 10)
                        
                        //execution block
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 90)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                            
                            VStack {
                                HStack{
                                    Text("execution")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_900)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        ProgressBarView(progress: self.$progressValueExecution)
                                            .frame(width: 56).onAppear() {
                                                self.progressValueExecution = 0.26
                                            }
                                        Text("26%")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.trailing, 40)
                                }
                                .padding(.top, 16)
                            }
                        } .frame(height: 90) .padding(.top, 10)
                        
                        //analytical block
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 90)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .padding(.top, 24)
                            
                            VStack {
                                HStack{
                                    Text("analytical")
                                        .padding(.leading, 40)
                                        .foregroundColor(.text_900)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        ProgressBarView(progress: self.$progressValueAnalytical)
                                            .frame(width: 56).onAppear() {
                                                self.progressValueAnalytical = 0.86
                                            }
                                        Text("86%")
                                            .foregroundColor(.text_900)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.trailing, 40)
                                }
                                .padding(.top, 16)
                            }
                        } .frame(height: 90) .padding(.top, 10) .padding(.bottom, 20)
                    }
                }
            } .navigationTitle("Progress")
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
