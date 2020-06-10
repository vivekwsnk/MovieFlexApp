//
//  FirstViewController.swift
//  MovieFlixApp
//


import UIKit

class NowPlayingMovieVC: UIViewController,ViewModelDelegate,UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: nil)
     var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var activityIndicator = UIActivityIndicatorView()
    var arrayItems: [movieObject]?
    var serchItems: [movieObject]?
    let cellIdentifier = "movieCell"
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Movies"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = UIColor.yellow
            //s.barStyle = .default
        s.sizeToFit()
        return s
    }()
    @IBOutlet weak var movieCollectionView: UICollectionView!
    func reloadTable(type: Int) {
        DispatchQueue.main.sync {
          //  self.movieCollectionView.reloadItems(at: [IndexPath(row: type, section: 0)], with: .fade)
            let dataItems = viewModel.dataItems[0]
            //cell.configure(whitViewModel: dataItems, row: indexPath.item)
            
            arrayItems = dataItems.results
            
            self.movieCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    var viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
         activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.alpha = 1.0
        movieCollectionView.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0);
        activityIndicator.startAnimating()
        viewModel.getMovies(type: .NowPlaying)
        self.navigationController?.isNavigationBarHidden = true

        movieCollectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:cellIdentifier)

        setupCollectionView()
       // setupCollectionViewItemSize()
        // Do any additional setup after loading the view.
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView?.registerNib(MovieCustomCell.stringRepresentation)
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        movieCollectionView.setCollectionViewLayout(layout, animated: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
   
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "movieCell", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
    
//    private func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText \(searchText)")
//        filterFootballers(for: searchText ?? "")
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        filterFootballers(for: searchText ?? "")
    }

    
    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text ?? "0")")
    }
    
    private func filterFootballers(for searchText: String) {
        let row = arrayItems?[0]
        serchItems = arrayItems!.filter { row in
            return (row.title.lowercased().contains(searchText.lowercased()))
        }
        
        if searchText.count > 4
        {
            movieCollectionView.reloadData()
        }
        if searchText.count == 0
        {
            movieCollectionView.reloadData()
        }
       //
    }
}


extension NowPlayingMovieVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if arrayItems?.count == nil
        {
            return 0
        }
        if  searchBar.text != "" {
            return serchItems!.count
        }
        else
        {
             return self.arrayItems!.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCustomCell
        
          //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCustomCell.stringRepresentation, for: indexPath) as! MovieCustomCell
        
        //if arrayItems > 0 {
//            let dataItems = viewModel.dataItems[indexPath.row]
//            //cell.configure(whitViewModel: dataItems, row: indexPath.item)
//
//            arrayItems = dataItems.results
        
       
        if searchBar.text != ""{
            let row = serchItems?[indexPath.row]
            
            cell.movieTitle.text = row?.title
            cell.movieDescription.text = row?.overview
            
            cell.movieDescription.lineBreakMode = .byWordWrapping //in versions below swift 3 (messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping)
            cell.movieDescription.numberOfLines = 0 //To write any number of lines within a label scope
            
            cell.movieDescription.textAlignment = .left
            cell.movieDescription.sizeToFit()
            
            print(cell.frame.size.height)
            print(cell.movieDescription.frame.size.height)
            
            ImageLoader.getImagen(name: row!.poster_path, round: false, width: 300, height: 400, completion: { (image) in
                cell.movieImg.image = image
                cell.movieImg.isHidden = false
            })
            
        } else {
            let row = arrayItems?[indexPath.row]
            
            cell.movieTitle.text = row?.title
            cell.movieDescription.text = row?.overview
            
            cell.movieDescription.lineBreakMode = .byWordWrapping //in versions below swift 3 (messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping)
            cell.movieDescription.numberOfLines = 0 //To write any number of lines within a label scope
            
            cell.movieDescription.textAlignment = .left
            cell.movieDescription.sizeToFit()
            
            print(cell.frame.size.height)
            print(cell.movieDescription.frame.size.height)
            
            ImageLoader.getImagen(name: row!.poster_path, round: false, width: 300, height: 400, completion: { (image) in
                cell.movieImg.image = image
                cell.movieImg.isHidden = false
            })
        }
    

        
       // }
        return cell
    }
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let MovieDetailInstance = mainStoryBoard.instantiateViewController(withIdentifier: AppConstants.ViewControllerIdentifier.MOVIEDETAILCONTROLLER) as! movieDetailViewController
        
        if searchBar.text != ""{
            let row = serchItems?[indexPath.row]
            
            
            MovieDetailInstance.titleString = row!.title
            MovieDetailInstance.dateString = row!.release_date
            MovieDetailInstance.detailString = row!.overview
            
            ImageLoader.getImagen(name: row!.poster_path, round: false, width: 300, height: 400, completion: { (image) in
               MovieDetailInstance.finalImage = image
                
            })
            
        } else {
            let row = arrayItems?[indexPath.row]
            
            MovieDetailInstance.titleString = row!.title
            MovieDetailInstance.dateString = row!.release_date
            MovieDetailInstance.detailString = row!.overview
            
            
            ImageLoader.getImagen(name: row!.poster_path, round: false, width: 300, height: 400, completion: { (image) in
                MovieDetailInstance.finalImage = image
                
            })
            
        }
        
       
        
        self.navigationController?.pushViewController(MovieDetailInstance, animated: true)
        
    }
   
    
    
}
extension NowPlayingMovieVC: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCustomCell
        cell.frame.size.height = (225) + (cell.movieDescription.frame.size.height)
        let size = CGSize(width: 400, height: cell.frame.size.height )
        return size
    }
}
