//
//  SecondViewController.swift
//  MovieFlixApp


import UIKit

class TopRatedVC: UIViewController,ViewModelDelegate,UISearchBarDelegate {
    @IBOutlet weak var topratedCollectionView: UICollectionView!
    @IBOutlet weak var newSearchBar: UISearchBar!

    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
       var activityIndicator = UIActivityIndicatorView()
    var arrayItems: [movieObject]?
    var serchItems: [movieObject]?
    let cellIdentifier = "TopRatedCell"
    private let refreshControl = UIRefreshControl()

    
   
    func reloadTable(type: Int) {
        DispatchQueue.main.sync {
            //  self.movieCollectionView.reloadItems(at: [IndexPath(row: type, section: 0)], with: .fade)
            let dataItems = viewModel.dataItems[0]
            //cell.configure(whitViewModel: dataItems, row: indexPath.item)
            
            arrayItems = dataItems.results
            
            self.topratedCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getMovies(type: .TopRate)
        
        activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.alpha = 1.0
        topratedCollectionView.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0);
        activityIndicator.startAnimating()
        self.navigationController?.isNavigationBarHidden = true
        
        topratedCollectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:cellIdentifier)

        
        setupCollectionView()
        
         newSearchBar.delegate = self
        
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        topratedCollectionView.alwaysBounceVertical = true
        topratedCollectionView.refreshControl = refreshControl // iOS 10+
        // setupCollectionViewItemSize()
        // Do any additional setup after loading the view.
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        activityIndicator.startAnimating()
        viewModel.getMovies(type: .TopRate)
        refreshControl.endRefreshing()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setupCollectionView() {
        topratedCollectionView.delegate = self
        topratedCollectionView.dataSource = self
        topratedCollectionView?.registerNib(MovieCustomCell.stringRepresentation)
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        topratedCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        newSearchBar.showsCancelButton = true
        searchMovieFilter(for: searchText ?? "")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //newSearchBar.text = ""
        self.newSearchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //newSearchBar.text = nil
        newSearchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        newSearchBar.endEditing(true)
        
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
    
    
    private func searchMovieFilter(for searchText: String) {
        let row = arrayItems?[0]
        serchItems = arrayItems!.filter { row in
            return (row.title.lowercased().contains(searchText.lowercased()))
        }
        topratedCollectionView.reloadData()
        
        
    }
    
    
}


extension TopRatedVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if arrayItems?.count == nil
        {
            return 0
        }
        if  newSearchBar.text != "" {
            return serchItems!.count
        }
        else
        {
            return self.arrayItems!.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topratedCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TopRateCustomCell
        
        
        if newSearchBar.text != ""{
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
            
            cell.index = indexPath
            cell.delegate = self
            
           
            
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
            
            cell.index = indexPath
            cell.delegate = self
            
        }
        
        // }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let MovieDetailInstance = mainStoryBoard.instantiateViewController(withIdentifier: AppConstants.ViewControllerIdentifier.MOVIEDETAILCONTROLLER) as! movieDetailViewController
        
        if newSearchBar.text != ""{
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
extension TopRatedVC: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = topratedCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TopRateCustomCell
        cell.frame.size.height = (225) + (cell.movieDescription.frame.size.height)
        let size = CGSize(width: 400, height: cell.frame.size.height )
        return size
    }
}


extension TopRatedVC: DataCollectionProtocolForRated
{
    func deleteData(indx: Int) {
        self.remove(indx)
    }
    
    
    func remove(_ i: Int) {
        
        if newSearchBar.text != ""{
            
            
            serchItems?.remove(at: i)
            
            let indexPath = IndexPath(row: i, section: 0)
            
            self.topratedCollectionView.performBatchUpdates({
                self.topratedCollectionView.deleteItems(at: [indexPath])
            }) { (finished) in
                self.topratedCollectionView.reloadItems(at: self.topratedCollectionView.indexPathsForVisibleItems)
            }
            
        }else
        {
            
            arrayItems?.remove(at: i)
            
            let indexPath = IndexPath(row: i, section: 0)
            
            self.topratedCollectionView.performBatchUpdates({
                self.topratedCollectionView.deleteItems(at: [indexPath])
            }) { (finished) in
                self.topratedCollectionView.reloadItems(at: self.topratedCollectionView.indexPathsForVisibleItems)
            }
        }
        
        
        
    }
}
