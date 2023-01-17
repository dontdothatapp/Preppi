//
//  OnboardingPageModel.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page (name: "Want to rock the interview?", description: "With our app, you can practice answering common interview questions at your own pace. Simply open the app and get a randomly selected question to start practicing", imageUrl: "onboarding_3", tag: 0)
    
    static var samplePages: [Page] = [
    Page(name: "Want to rock the interview?", description: "Our app will give you the tools you need to succeed in your next interview", imageUrl: "onboarding_1", tag: 0),
    Page(name: "Practice all the questions!", description: "With our app, you can practice answering common interview questions at your own pace. Simply open the app and get a randomly selected question to start practicing", imageUrl: "onboarding_2", tag: 1),
    Page(name: "Ace Your Interviews", description: "By practicing with our app, you'll improve your confidence and increase your chances of success in your job interviews.", imageUrl: "onboarding_3", tag: 2),
    ]
}
