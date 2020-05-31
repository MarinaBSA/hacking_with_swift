//
//  ViewController.swift
//  stormViewer
//
//  Created by Marina Beatriz Santana de Aguiar on 31.05.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    let pictureIdentifier = "Picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
        let fm = FileManager.init()
        let filePrefix = "nssl"
        
        // Bundle: Contains compiled programm and all assets
        let data = try! fm.contentsOfDirectory(atPath: Bundle.main.bundlePath)
        for picture in data {
            if picture.hasPrefix(filePrefix) { pictures.append(picture) }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pictureIdentifier, for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
 
}

