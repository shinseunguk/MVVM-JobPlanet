//
//  Enterprise2TableViewCell.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import UIKit

class Enterprise2TableViewCell: UITableViewCell {
    let forCellWithReuseIdentifier = "EnterpriseCollectionViewCell"
    
    weak var delegate : PushScreen?
    
    var appealArray : [String] = [""]
    
    var param : [EnterpriseList]? {
        didSet {
            print("param!! \(param)")
            self.label.text = param?[0].sectionTitle
            collectionView.register(UINib(nibName: "EnterpriseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: forCellWithReuseIdentifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let view1 = UIView()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let label : UILabel = {
        let view = UILabel()
//        view.text = "인기 급상승 채용 공고"
        view.textColor = .jpgray01
        view.font = .boldSystemFont(ofSize: 24)
        view.sizeToFit()
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
        contentView.addSubview(view1)
        
        
        _ = [label,collectionView].map {
            view1.addSubview($0)
//            view1.layer.borderWidth = 1
//            $0.layer.borderWidth = 1
        }
        
        view1.snp.makeConstraints{(make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        label.snp.makeConstraints{(make) in
            make.left.top.equalTo(20)
            //            make.width.equalTo(150)
        }
        
        collectionView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension Enterprise2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = param?[0].count else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = param?[0], let recommendRecruit = param?[0].recommendRecruit else {return UICollectionViewCell()}
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forCellWithReuseIdentifier, for: indexPath) as? EnterpriseCollectionViewCell else { fatalError("can't dequeue CustomCell") }
        
        //id
        cell.id = recommendRecruit[indexPath.row].id
        
        let rating = ratingAVG(recommendRecruit[indexPath.row].company?.ratings)
        let appeal : String = recommendRecruit[indexPath.row].appeal!
        var appealArray = appeal.components(separatedBy: ", ")
        appealArray = arraySortByCount(appealArray)
        
        //url에 정확한 이미지 url 주소를 넣는다.
        let url = URL(string: recommendRecruit[indexPath.row].image_url!)
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
        cell.id = recommendRecruit[indexPath.row].id
        cell.titleLabel.text = recommendRecruit[indexPath.row].title
        cell.companyLabel.text = recommendRecruit[indexPath.row].company?.name
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
        
        
        print("recommendRecruit[indexPath.row].reward \(recommendRecruit[indexPath.row].reward)")
        
        if recommendRecruit[indexPath.row].reward != 0 {
            var rewardFormatting = recommendRecruit[indexPath.row].reward?.commaRepresentation
            cell.rewardLabel.text = "축하금 \(rewardFormatting!)원"
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#file , #function)
        return CGSize(width: 160, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = param?[0].recommendRecruit {
            print(model[indexPath.row])
            self.delegate?.pushScreen(model[indexPath.row])
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
