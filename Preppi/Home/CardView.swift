//
//  CardView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct CardView: View {
    
    //@ObservedObject var questionModel = QuestionModel()
    @ObservedObject var questionModel = QuestionModel()
    @State var firstCard: Bool
    @State var isSaved: Bool = false
    @State var isMastered: Bool = false
    
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
                HStack {
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
                            } else {
                                saveQuestionButton()
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
                        
                        //Mastered button
                        Button {
                            if isMastered == true {
                                deleteFromMastered()
                            } else {
                                masterQuestionButton()
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
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                
            } .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
        } .onChange(of: question.id) { newValue in
            questionModel.checkSavedQuestion(questionID: newValue) { isSavedModel in
                isSaved = isSavedModel
                print("DEBUG: IsSaved value is: \(isSaved)")
            }
        } .onChange(of: question.id) { newValue in
            questionModel.checkMasteredQuestion(questionID: newValue) { isMasteredModel in
                isMastered = isMasteredModel
                print("DEBUG: isMastered value is: \(isMastered)")
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
    
//    func fetchIfItsSaved() {
//        questionModel.checkSavedQuestion(questionID: question.id) { isSavedModel in
//            isSaved = isSavedModel
//            print("DEBUG: IsSaved value is: \(isSaved)")
//        }
//    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(firstCard: false, isSaved: false, question: Question(id: "1", category: "test", question: "Sample question just an example for a preview", type: "product", timestamp: Date()))
    }
}
