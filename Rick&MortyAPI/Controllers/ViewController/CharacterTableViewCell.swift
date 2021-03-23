//
//  CharacterTableViewCell.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/21/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    
    // MARK: - Properties
    var character: Character? {
        didSet {
            guard let character = character else {return}
            self.characterNameLabel.text = character.name
            self.characterSpeciesLabel.text = "Species: \(character.species)"
            self.characterStatusLabel.text = "Status: \(character.status)"
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
    }
}
