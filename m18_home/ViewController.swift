//
//  ViewController.swift
//  m18_home
//
//  Created by Михаил Ганин on 13.04.2023.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var films: Films? = nil
    let cellIdentifer = "Cell"

    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var seacrhBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        table.register( Cell.self, forCellReuseIdentifier: cellIdentifer)
        table.dataSource = self
        table.delegate = self
        seacrhBar.delegate = self
        setupView()
        setupConstraints()
       
        
        // Do any additional setup after loading the view.
    }
    private func setupView() {
        view.addSubview(table)
        view.addSubview(seacrhBar)
        
    }
    
    private func setupConstraints() {
        seacrhBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(400)
            make.height.equalTo(50)
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(seacrhBar)
            make.width.equalTo(400)
            make.height.equalTo(200)
            make.bottom.equalTo(0)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
       
    }
    
    
 }

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
 }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films?.results.count ?? 0
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! Cell
        let films = films?.results[indexPath.row]
        cell.initCell(item: films!)
        cell.textToShow = films!.title
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let seacrtText = searchBar.text {
            
            
            let url = "https://imdb-api.com/API/Search/k_0j1su9zn/\(seacrtText)"
            print(url)
            networkService.featchRequest(urlString: url) { Films, error in
                if let result = Films?.results {
                    for title in result {
                        self.films = Films
                        self.table.reloadData()
                    }
                   
                }
            }
        }
    }
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//                              cразу обновляет
//    }
}


