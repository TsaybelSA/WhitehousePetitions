//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Сергей Цайбель on 03.06.2022.
//

import UIKit

class ViewController: UITableViewController {
	var petitions = [Petition]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Whitehouse Petitions"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
		
		do {
			guard let url = URL(string: urlString) else { fatalError() }
			let data = try Data(contentsOf: url)
			parse(json: data)
		} catch {
			print("Failed to load data from url: \(urlString)")
		}

	}
	
	func parse(json: Data) {
		guard let decoded = try? JSONDecoder().decode(Petitions.self, from: json) else { return }
		petitions = decoded.results
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = petitions[indexPath.row]
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		let petiton = petitions[indexPath.row]
		vc.detailItem = petiton
		navigationController?.pushViewController(vc, animated: true)
		
	}

}

