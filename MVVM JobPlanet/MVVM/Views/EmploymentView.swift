//
//  EmploymentView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import Foundation
import UIKit
import Kingfisher

protocol PushParam: AnyObject {
    func moveParam(_ model1: EmploymentModel?,_ model2: EnterpriseModel?)
}

protocol PushScreen: AnyObject {
    func pushScreen(_ model: EmploymentDetail)
}

@IBDesignable
class EmploymentView: UIView{
    let cellWithReuseIdentifier = "EmploymentCollectionViewCell"
    let helper = Helper()
    let viewModel = EmploymentViewModel.shared
    var model : EmploymentModel? {
        didSet {
            self.pushDelegate?.moveParam(model, nil)
        }
    }
    
    var device = UIDevice.current.model
    
    var appealArray : [String] = [""]
    
    weak var delegate : PushScreen?
    weak var pushDelegate : PushParam?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.showsVerticalScrollIndicator = false
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets.zero
            
            //        flowLayout.minimumInteritemSpacing = 2 // 좌우 margin
            flowLayout.minimumLineSpacing = 20 // 위아래 margin
            
            let halfWidth = UIScreen.main.bounds.width / 2
            if device.contains("iPad") {
                flowLayout.itemSize = CGSize(width: halfWidth - 30 , height: halfWidth - 50)
            }else {
                flowLayout.itemSize = CGSize(width: halfWidth - 30 , height: 226)
            }
            flowLayout.footerReferenceSize = CGSize(width: halfWidth * 3, height: 70)
            flowLayout.sectionFootersPinToVisibleBounds = true
            //        flowLayout.sectionInset = UIEdgeInsets(top:5, left:15, bottom:5, right:7.5);
            
            self.collectionView.collectionViewLayout = flowLayout
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        print(#file , #function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundle = Bundle(for: EmploymentView.self)
        bundle.loadNibNamed("EmploymentView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        viewModel.employmentReqeust()
        
        viewModel.didFinishFetch = {
            self.model = self.viewModel.employmentModel
            
            let nib = UINib(nibName: "EmploymentCollectionViewCell", bundle: nil)
            self.collectionView.register(nib, forCellWithReuseIdentifier: "EmploymentCollectionViewCell")
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
}

extension EmploymentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recruit_items = self.model?.recruit_items {
            return recruit_items.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath) as? EmploymentCollectionViewCell else { fatalError("can't dequeue CustomCell") }
        if let model = self.model?.recruit_items {
            
            let rating = ratingAVG(model[indexPath.row].company?.ratings)
            
            let appeal : String = model[indexPath.row].appeal!
            var appealArray = appeal.components(separatedBy: ", ")
            appealArray = arraySortByCount(appealArray)
            
            //url에 정확한 이미지 url 주소를 넣는다.
            let url = URL(string: model[indexPath.row].image_url!)
            //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
            //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
//                    cell.imageView.image = UIImage(data: data!)
                    cell.imageView.kf.indicatorType = .activity
                    cell.imageView.kf.setImage(
                      with: url,
                      placeholder: nil,
                      options: nil,
                      completionHandler: nil
                    )
                }
            }
            cell.id = model[indexPath.row].id
            cell.titleLabel.text = model[indexPath.row].title
            cell.companyLabel.text = model[indexPath.row].company?.name
            cell.ratingLabel.text = rating
            
            
            // 글자수로 count해 appeal 칼럼을 한개만 뿌려줄건지 두개만 뿌려줄건지 set
            if appealArray.count != 0 && appealArray[0].count != 0 {
                if appealArray.count == 1 || appealArray[0].count + appealArray[1].count > 10{ // appeal 칼럼이 한개 || appeal0, appeal1 글자수가 10개 초과일때
                    cell.appealLabel1.text = appealArray[0]
                    cell.appealLabel2.removeFromSuperview()
                }else if appealArray[0].count + appealArray[1].count < 10{ // appeal0, appeal1 글자수가 10개 미만일때
//                    print("appealArray[0].count \(appealArray[0].count)")
//                    print("appealArray[1].count \(appealArray[1].count)")
                    cell.appealLabel1.text = appealArray[0]
                    cell.appealLabel2.text = appealArray[1]
                }
            }else {
                cell.appealLabel1.removeFromSuperview()
                cell.appealLabel2.removeFromSuperview()
            }
            
            
            
            if model[indexPath.row].reward != 0 {
                var rewardFormatting = model[indexPath.row].reward?.commaRepresentation
                cell.rewardLabel.text = "축하금 \(rewardFormatting!)원"
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.model?.recruit_items![indexPath.row] {
            print(model)
            self.delegate?.pushScreen(model)
        }
    }
    
    // MARK: - 글자순대로 정렬
    func arraySortByCount(_ array : [String]) -> [String] {
        appealArray = array.sorted(by: { $0.count < $1.count })
//        print(appealArray)
        return appealArray
    }
    
    // MARK: - rating 평균내기
    func ratingAVG(_ ratingDetail : [ratingDetail]?) -> String{
        var avg = 0.0
        if let ratingDetail = ratingDetail {
            for x in 0...ratingDetail.count-1 {
//                print("rating => ",ratingDetail[x].rating)
                avg += ratingDetail[x].rating!
            }
            avg = avg / CGFloat(ratingDetail.count)
            
            return String(round(avg))
        }else {
            return "0.0"
        }
    }
}
