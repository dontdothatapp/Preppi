//
//  CardView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI
import ConfettiSwiftUI
import StoreKit

struct CardView: View {
    
    //@ObservedObject var questionModel = QuestionModel()
    @ObservedObject var questionModel = QuestionModel()
    @State var firstCard: Bool
    @State var isSaved: Bool = false
    @State var isMastered: Bool = false
    @State private var masteredCounter: Int = 0
    @State var savedCounter = 0
    @State private var showPremiumOffer = false
    @State var masteredPerSession = 0
    @State public var animationForSaved = false
    @State var masteredQuestions = [Question]()
    @State var savedQuestions = [Question]()
    @Environment(\.requestReview) var requestReview
    
    let question: Question
    //var saveQuestion: (Question) -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
                .foregroundColor(.additional_50)
                .cornerRadius(16)
                .padding(.top, 24)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
            
            VStack {
                Spacer()
                
                //Tag
                HStack (alignment: .top) {
                    Text(question.category)
                    //.padding(.leading, 40)
                    //.padding(.top, 40)
                        .padding(.bottom, 10)
                        //.underline()
                        .foregroundColor(Color.text_500)
                    Spacer()
                }
                .padding(.leading, 20)
                
                //Main text
                HStack {
                    Text(question.question)
                        .font(.title)
                        .foregroundColor(.text_900)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.leading, 20)
                //.offset(y: 20)
                Spacer()
                
                if firstCard == true {
                    
                } else {
                    //Save & Mastered buttons
                    HStack{
                        
                        //Save button
                        Button {
                            
                            if isSaved == true {
                                deleteFromSaved()
                                animationForSaved.toggle()
                            } else {
                                saveQuestionButton()
                                fetchSavedQuestions()
                                
                                if savedQuestions.count == 5 {
                                    requestReview()
                                } else {
                                    if savedCounter < 3 {
                                        showPremiumOffer = false
                                        savedCounter += 1
                                        print("DEBUG: savedCounter = \(savedCounter)")
                                        animationForSaved.toggle()
                                    } else {
                                        showPremiumOffer = true
                                        savedCounter = 0
                                    }
                                }
                            }
                        } label: {
                            HStack{
                                if isSaved == true {
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(.primary_900)
                                    Text("Saved")
                                        .foregroundColor(.text_900)
                                    Spacer()
                                } else {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(.primary_900)
                                    Text("Save")
                                        .foregroundColor(.text_900)
                                    Spacer()
                                }
                                
                            } .frame(width: 100) .padding(.leading, 20)
                        }
                        .fullScreenCover(isPresented: $showPremiumOffer, content: PremiumView.init)
                        
                        //Mastered button
                        Button {
                            if isMastered == true {
                                deleteFromMastered()
                            } else {
                                masterQuestionButton()
                                masteredCounter += 1
                                masteredPerSession += 1
                                //getMasteredQuestionsArray()
                                
                                if masteredQuestions.count == 3 {
                                    requestReview()
                                }
                            }
                        } label: {
                            HStack{
                                if isMastered == true {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.primary_900)
                                    Text("Mastered")
                                        .foregroundColor(.text_900)
                                } else {
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.primary_900)
                                    Text("Mastered")
                                        .foregroundColor(.text_900)
                                }
                            }
                        } .confettiCannon(counter: $masteredCounter, num: 20, rainHeight: 600.0, opacity: 0.7, openingAngle: Angle.degrees(-10), closingAngle: Angle.degrees(-90), radius: 200.0)
                        
                        Spacer()
                        
                        ShareLink(item: "How you would answer this question?",
                                  subject: Text("How you would answer this question?"),
                                  message: Text("How would you answer the question: \(question.question) The question from the Preppi app: https://github.com/dontdothatapp"),
                                  preview: SharePreview("How would you answer the question?", image: Image("AppIcon"))) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    //.font(.system(size: 15))
                                    .padding(.trailing, 20)
                                    .foregroundColor(isSaved ? Color.primary_300 : Color.text_500)
                            }
                        }
                        
                    }
                    .padding(.bottom, 20)
                }
                
            } .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
        } .onChange(of: question.id) { newValue in
            questionModel.checkSavedQuestion(questionID: newValue) { isSavedModel in
                isSaved = isSavedModel
            }
        } .onChange(of: question.id) { newValue in
            questionModel.checkMasteredQuestion(questionID: newValue) { isMasteredModel in
                isMastered = isMasteredModel
            }
        }
    }
    
    func saveQuestionButton() {
        questionModel.saveQuestion(questionId: question.id)
    }
    
    func masterQuestionButton() {
        questionModel.masterQuestion(questionId: question.id)
    }
    
    func deleteFromSaved() {
        questionModel.deleteSavedQuestion(questionId: question.id)
    }
    
    func deleteFromMastered() {
        questionModel.deleteMasteredQuestion(questionId: question.id)
    }
    
    func savedCounterUpdate() {
        if savedCounter < 3 {
            savedCounter += 1
        } else {
            savedCounter = 0
        }
    }
    
    func fetchSavedQuestions() {
        questionModel.getSavedQuestions { (questions) in
        self.savedQuestions = questions
      }
    }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(firstCard: false, isSaved: true, question: Question(id: "1", category: "test", question: "Sample question just an example for a preview", type: "product", timestamp: Date()))
    }
}
