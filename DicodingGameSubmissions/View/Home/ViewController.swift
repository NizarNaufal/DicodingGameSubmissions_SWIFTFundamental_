//
//  ViewController.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 24/02/21.
//

import UIKit
import Nuke


class ViewController: UIViewController,UITabBarDelegate {
    
    @IBOutlet var gameTableView: UITableView!
    @IBOutlet weak var homeBtnTabBar: UITabBarItem!
    @IBOutlet weak var favBtnTabBar: UITabBarItem!
    @IBOutlet weak var profileBtnTabBar: UITabBarItem!
    @IBOutlet weak var tabBarHome: UITabBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var gamesData = [GameData]()
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadingIndicator.isHidden = false
        
        tabBarHome.delegate = self
        tabBarHome.selectedItem = tabBarHome.items![0]
        
        gameManager.delegate = self
        gameManager.fetchGames()
        
        let contentModes = ImageLoadingOptions.ContentModes(
            success: .scaleAspectFill,
            failure: .scaleAspectFill,
            placeholder: .scaleAspectFill)
        
        ImageLoadingOptions.shared.contentModes = contentModes
        ImageLoadingOptions.shared.placeholder = UIImage(named: "loading-image-cardview-game-poster")
        ImageLoadingOptions.shared.failureImage = UIImage(named: "fail-to-load-image")
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.5)
        
        DataLoader.sharedUrlCache.diskCapacity = 0
        
        let pipeline = ImagePipeline {
            // 2
            let dataCache = try! DataCache(name: "id.dicoding.learn.DicodingGameSubmissions.datacache")
            
            // 3
            dataCache.sizeLimit = 200 * 1024 * 1024
            
            // 4
            $0.dataCache = dataCache
        }
        
        // 5
        ImagePipeline.shared = pipeline
        
        
        gameTableView.delegate = self
        gameTableView.dataSource = self
        gameTableView.register(UINib(nibName: "RawTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")

    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1) {
            // Code for item 1
            
            let home = ViewController(nibName: "ViewController", bundle: nil)
            self.navigationController?.pushViewController(home, animated: true)
            
        }else if(item.tag == 2) {
            // Code for item 2
            tabBarHome.selectedItem = tabBarHome.items![0]
            
            let fav = ProfileCatGue(nibName: "ProfileCatGue", bundle: nil)
            self.navigationController?.pushViewController(fav, animated: true)
        }
    }
    
    func parseDate(dateUnformatted: String)-> String{
        
        let fullDateArr : [String] = dateUnformatted.components(separatedBy: "-")
        let year = fullDateArr[0]
        let month = getMonthName(month: fullDateArr[1])
        let day = fullDateArr[2]
        let formattedDate : String = "\(day) \(month) \(year)"
        return formattedDate
    }
    
    func getMonthName(month: String)-> String{
        switch month {
        case "01":
            return "January"
        case "02":
            return "February"
        case "03":
            return "March"
        case "04":
            return "April"
        case "05":
            return "Mei"
        case "06":
            return "June"
        case "07":
            return "July"
        case "08":
            return "August"
        case "09":
            return "September"
        case "10":
            return "Oktober"
        case "11":
            return "November"
        case "12":
            return "Desember"
        default:
            return " "
        }
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Memanggil View Controller dengan berkas NIB/XIB di dalamnya
        let detail = DetailPage(nibName: "DetailPageView", bundle: nil)
        
        
        detail.game = GameModel(
            id: gamesData[indexPath.row].gameId,
            poster: gamesData[indexPath.row].gamePoster,
            title: gamesData[indexPath.row].gameTitle,
            releasedDate: gamesData[indexPath.row].gameReleasedDate,
            rating: String(gamesData[indexPath.row].gameRating))
        
        // Push mendorong view controller lain
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesData.count
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gameTableView.dequeueReusableCell(withIdentifier: "GameCell", for : indexPath) as! RawTableViewCell

        
        let game = gamesData[indexPath.row]
        
        // This line doesn't change
        let url = URL(string : game.gamePoster)
        let request = ImageRequest(
            url: url!,
            targetSize: CGSize(width: 280, height: 170),
            contentMode: .aspectFill)
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "loading-image-cardview-game-poster"),
            transition: .fadeIn(duration: 0.5)
        )
        
        Nuke.loadImage(with: request, options: options, into: cell.gamePoster)
        cell.gameTitle.text = game.gameTitle
        cell.gameRating.text = String(game.gameRating)
        cell.gameReleasedDates.text = "Released Date : \(parseDate(dateUnformatted: game.gameReleasedDate))"
        
        return cell
    }
    
}

extension ViewController : RawManagerDelegate{
    
    func didUpdateGame(_ gameManager: GameManager, game: GamesModels) {
        if game.results.count > 0{
            for item in game.results{
                gamesData.append(item)
                print("item appended : \(item.gameTitle)")
            }
            DispatchQueue.main.async() {
                self.loadingIndicator.isHidden = true
                self.gameTableView.reloadData()
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
