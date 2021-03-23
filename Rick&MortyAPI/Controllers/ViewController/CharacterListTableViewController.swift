//
//  CharacterListTableViewController.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/21/21.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    // MARK: - Properties
    var characters: [Character] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        characterSearchBar.delegate = self
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        let character = characters[indexPath.row]
        cell.character = character
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = CharacterController.characters[indexPath.row]
        if let viewController = storyboard?.instantiateViewController(identifier: "characterDetailVC") as? CharacterDetailViewController {
            viewController.character = selectedCharacter
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - Extensions
extension CharacterListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty
        else {return}
        let character = searchTerm.lowercased()
        CharacterController.fetchCharacter(withSearchTerm: character) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters = characters
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
