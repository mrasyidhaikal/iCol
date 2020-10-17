//
//  ViewController2.swift
//  iCol
//
//  Created by Windy on 12/10/20.
//

import UIKit

class ChallengeViewController: UICollectionViewController {
    
    private let challenges = [
        Challenge(name: "Eat Less Gorengan", image: "Fried", type: .decrease),
        Challenge(name: "Eat More Vegetables", image: "Vegetable", type: .increase),
        Challenge(name: "Eat Less Fast Food", image: "Burger", type: .decrease),
        Challenge(name: "Drink Less Soda", image: "Soda", type: .decrease)
    ]
    
    init() {
        super.init(collectionViewLayout: ChallengeViewController.createLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        setupNavigation()
    }

    private func setupNavigation() {
        navigationItem.title = "What habit to build?"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollection() {
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: ChallengeCell.reuseIdentifier)
    }
    
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, environment) ->
            NSCollectionLayoutSection? in
          
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.55)))
            item.contentInsets.bottom = 16
            item.contentInsets.trailing = 8
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 20
            
            return section
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DescriptionViewController()
        vc.navigationItem.title = challenges[indexPath.row].name
        vc.type = challenges[indexPath.row].type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCell.reuseIdentifier, for: indexPath) as? ChallengeCell else { return UICollectionViewCell() }
        let challenge = challenges[indexPath.row]
        cell.challengeLabel.text = challenge.name
        cell.challengeImageView.image = UIImage(named: challenge.image)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges.count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
