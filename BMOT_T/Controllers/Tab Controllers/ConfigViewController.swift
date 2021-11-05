//
//  ConfigViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit

struct settingCellModel{
    let title: String
    let handler: (()->Void)
}

class ConfigViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[settingCellModel]]() // se declara una variable que contendra toda la informacion de cada celda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        let alertaCierre = UIAlertController(title: "Cerrar Sesión",
                                             message: "¿Estás seguro(a) que quieres cerrar sesión?",
                                             preferredStyle: .actionSheet) // Se crea una variable de tipo UIAlert donde vamos a mostrar el mensaje
        
        alertaCierre.addAction(UIAlertAction(title: "Cancelar",
                                             style: .cancel,
                                             handler: nil)) // Se crea un boton dentro de esta alerta el cual permitira cancelar la accion
        
        // Se crea un boton dentro de esta alerta el cual permitira seguir con el proceso
        alertaCierre.addAction(UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { _ in // Como es de tipo .destructive, continúa con el cierre de sesión
            AuthManager.shared.logoutUsuario(completion: {success in // Accedemos a la funcion de logout implementada en authManager controller
                DispatchQueue.main.async {
                    if success {
                        // Se regresa a la vista de Login en caso de que todo funcionó correctamente
                        let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
                        loginVC?.modalPresentationStyle = .fullScreen
                        //Mostrar el view controller
                        self.present(loginVC!, animated: true, completion: nil)
                        print("Logout exitoso")
                    }
                    else{
                        // Error en cerrar sesión
                        fatalError("No se pudo cerrar sesión")
                    }
                }
            })
        }))
        
        // instancias de alerta de mensaje
        alertaCierre.popoverPresentationController?.sourceView = tableView
        alertaCierre.popoverPresentationController?.sourceRect = tableView.bounds
        // mostrar alerta en pantalla
        present(alertaCierre, animated: true)
        
    }
    
    
    
}

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
