//
//  SecondPageViewModelClass.swift
//  FlipKartTest
//
//  Created by Shilpa Garg on 04/07/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

class SecondPageViewModelClass {
    
    var gameTimer: Timer?
    var seconds = 30
    
    var updateTimer : ((String)->())!
    var stopGame : ((score)->())!
    
    var startPageDifficultyNo = 3
    var pagesShown = 1
    var currentPageDifficultyNo = 3
    var maxPages = 5
    var score = 0
    
    func runTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode() {
        seconds -= 1
        updateTimer(seconds.description)
    }
    
    func resetTimer() {
        stopGameIfMaxReached()
        gameTimer?.invalidate()
        seconds = 30
        pagesShown = pagesShown < 5 ? pagesShown+1 : 5
        currentPageDifficultyNo = currentPageDifficultyNo == 5 ? 5 : currentPageDifficultyNo + 1
        updateTimer(seconds.description)
    }
    
    func stopTimer() {
        stopGameIfMaxReached()
        pagesShown += 1
        gameTimer?.invalidate()
        currentPageDifficultyNo -= 1
    }
    
    func stopGameIfMaxReached() {
        if pagesShown == 5 && currentPageDifficultyNo == 5 {
            stopGame(.won)
        }else if currentPageDifficultyNo == 1 {
            stopGame(.gameOver)
        }else if pagesShown == 5 {
            stopGame(.gameComplete)
        }
    }
    
}
