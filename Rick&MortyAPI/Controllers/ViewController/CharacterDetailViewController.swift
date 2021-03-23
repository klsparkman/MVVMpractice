//
//  CharacterDetailViewController.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/21/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    // MARK: - Properties
    var character: Character?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImageAndUpdateViews()
    }
    
    func fetchImageAndUpdateViews() {
        guard let character = character else { return }
        characterNameLabel.text = character.name
        
        CharacterController.fetchImage(for: character) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.characterImageView.image = image
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
