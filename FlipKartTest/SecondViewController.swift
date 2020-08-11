//
//  SecondViewController.swift
//  FlipKartTest
//
//  Created by Shilpa Garg on 04/07/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

enum score {
    case gameOver
    case won
    case gameComplete
    
    func text() -> String {
        switch self {
        case .gameOver:
            return "Game Over!"
        case .won:
            return "You won!"
        case .gameComplete:
            return "Game Complete"
        }
    }
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var pageNoLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var viewModel : SecondPageViewModelClass? = SecondPageViewModelClass ()
    
    var imageData : AnimalResponse?
    var apiData: [AnimalResponse]?
    
    override func viewDidLoad() {
        timerLabel.clipsToBounds = true
        timerLabel.backgroundColor = .white
        timerLabel.layer.cornerRadius = 50
        timerLabel.textAlignment = .center
        
        super.viewDidLoad()
        loadEvents { data in
            apiData = data
            updateImage()
        }
        viewModel?.stopGame = { type in
            self.showAlert(type: .gameOver)
        }
        viewModel?.runTimer()
        viewModel?.updateTimer = { [weak self ] value in
            guard let weakSelf = self else {return}
            
            weakSelf.timerLabel.text = "\(value)"
            
            if value == "0" {
                weakSelf.viewModel?.stopTimer()
                weakSelf.updateImage()
            }
        }
    }
    
    func updateImage() {
        animalImageView.image = nil
        imageData = apiData?.filter
        {
            ($0.difficulty == viewModel?.currentPageDifficultyNo) && $0.isShown ?? false == false
        }[0]
        DispatchQueue.main.async
        {
            self.imageData?.updateIsShown()
            self.animalImageView.setImage(for: self.imageData?.imageURL ?? "")
            self.pageNoLabel.text = "\(self.viewModel?.pagesShown ?? 1)-5"
            self.answerTextfield.text = ""
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if answerTextfield.text?.capitalized == imageData?.answer?.capitalized {
            self.viewModel?.resetTimer()
        }else {
            self.viewModel?.stopTimer()
        }
        if viewModel?.pagesShown ?? 1 <= viewModel?.maxPages ?? 5 {
            updateImage()
        }
    }
    
}

extension SecondViewController {
    func loadEvents(completion: (responseData) -> Void) {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "response", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let result = try? decoder.decode(responseData.self, from: data) else { return }
        completion(result)
    }
}

extension SecondViewController {
    
    func showAlert(type: score)  {
        let alert = UIAlertController(title: "Alert", message: type.text(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.navigationController?.popToRootViewController(animated: false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
