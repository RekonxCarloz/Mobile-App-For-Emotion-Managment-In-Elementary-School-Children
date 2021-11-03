//
//  ChooseProfileViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit

class ChooseProfileViewController: UIViewController {
    
    //MARK: - Declaración de IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var listaPerfiles:[ProfileList] = []
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        
        
        
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

extension ChooseProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaPerfiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let perfil = listaPerfiles[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellProfile", for: indexPath) as! CustomProfileCell
        cell.nameProfile.text = perfil.nombre
        cell.avatarImage.image = perfil.avatar
        
        return cell
    }
    
    
}
