//
//  HomeViewController.swift
//  MovieApp-UIKit
//
//  Created by Berkay Disli on 14.03.2023.
//

import UIKit

enum Sections: Int {
    case trendingMovies, trendingTv, populars, upcoming, topRated
}

class HomeViewController: UIViewController {
    let sectionTitles = ["Trendıng Movıes", "Trendıng TV", "Popular", "Upcomıng Movıes", "Top Rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        let headerView = HeroHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        
    }
    
    private func configureNavbar() {
        //var image = UIImage(named: "heroImage")
        //image = image?.withRenderingMode(.alwaysOriginal)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "MovieApp", style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { _ in
            
        }
    }
    
    private func getTrendingTVs() {
        APICaller.shared.getTrendingTVs { _ in
            
        }
    }
    
    private func getUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { _ in
            
        }
    }
    
    private func getPopulars() {
        APICaller.shared.getPopular { _ in
            
        }
    }
    private func getTopRated() {
        APICaller.shared.getTopRated { _ in
            
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        
        cell.delegate = self
        
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { response in
                cell.configure(with: response.results)
            }
        case Sections.trendingTv.rawValue:
            APICaller.shared.getTrendingTVs { response in
                cell.configure(with: response.results)
            }
        case Sections.populars.rawValue:
            APICaller.shared.getPopular { response in
                cell.configure(with: response.results)
            }
        case Sections.upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { response in
                cell.configure(with: response.results)
            }
        case Sections.topRated.rawValue:
            APICaller.shared.getTopRated { response in
                cell.configure(with: response.results)
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        
        header.textLabel?.textColor = .white
        //header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
