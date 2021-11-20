//
//  ChooseProfileViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase

class ChooseProfileViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    //MARK: - Declaración de IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listaPerfiles:[ProfileList] = [ProfileList(nombre: "Carlos", avatar: "seriousMascot")]
    var nameToProfile: String?
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 170)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellIdentifier)
        collectionView.layer.backgroundColor = .none
        
        navigationItem.hidesBackButton = true
        loadData()
        
        
    }
    
    
    
    // MARK: - Load Data func
    
    private func loadData(){
        
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            ref.child(userEmail).child("perfiles").observe(DataEventType.value, with: { snapshot in
                
                self.listaPerfiles = []
                
                print("----------*****-----------")
                
                for child in snapshot.children{
                    
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    let name = dict["nombre"] as? String ?? ""
                    let avatar = dict["avatar"] as? String ?? ""
                    let newProfile = ProfileList(nombre: name, avatar: avatar)
                    self.listaPerfiles.append(newProfile)
                }
                print(self.listaPerfiles)
                print(self.collectionView!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print("----------*****-----------")
            })
        }
        
    }
    
    
    // MARK: - Cerrar sesión
    @IBAction func cerrarSesionButton(_ sender: UIButton) {
        AuthManager.shared.logoutUsuario(completion: {success in // Accedemos a la funcion de logout implementada en authManager controller
            DispatchQueue.main.async {
                if success {
                    // Se regresa a la vista de Login en caso de que todo funcionó correctamente
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else{
                    // Error en cerrar sesión
                    fatalError("No se pudo cerrar sesión")
                }
            }
        })
    }
    
    
    
}

extension ChooseProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaPerfiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let perfil = listaPerfiles[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! ProfileCollectionViewCell
        cell.nameProfile.setTitle(perfil.nombre, for: .normal)
        cell.profilePicture.image = UIImage(named: perfil.avatar)
        cell.nameProfile.addTarget(self, action: #selector(homeView), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
    @objc func homeView(sender: UIButton){
        
        nameToProfile = sender.title(for: .normal)
        performSegue(withIdentifier: K.Segues.chooseProfileToHome, sender: sender.tag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.chooseProfileToHome{
            let tabCtrl = segue.destination as! UITabBarController
            let navCtrl = tabCtrl.viewControllers![0] as! UINavigationController
            let destinoVC = navCtrl.topViewController as! HomeViewController
            destinoVC.nombrePerfil = nameToProfile
            
            let navCtrlGames = tabCtrl.viewControllers![1] as! UINavigationController
            let destinoVCGames = navCtrlGames.topViewController as! JuegosViewController
            destinoVCGames.nombrePerfil = nameToProfile
        }
        
    }
}
