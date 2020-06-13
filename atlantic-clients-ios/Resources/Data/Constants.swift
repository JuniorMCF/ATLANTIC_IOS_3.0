//
//  Constants.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/5/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation

class Constants {
    
    var urlBase = "https://wsclienteapp.azurewebsites.net/api/Cliente/"
    var dominioImages = "http://clienteatlantic.azurewebsites.net/admin/upload/imagen/"
    //metodos GET y POST
    //metodos GET
    var getLoginClients = "Login_cliente"
    var getSorteos =  "Sorteos"
    var getCobros = "Cobros"
    var getBeneficios = "Beneficios"
    var getBeneficiosTipo = "BeneficiosTipo"
    var getTorneos = "Torneos"
    var getTorneosTipo = "TorneosTipo"
    var getTorneosTabla = "TorneoTabla"
    var getEventoDetails = "EventoDetalles"
    var getEventoHorario = "EventoHorario"
    var getBuffet = "BuffetEvento"
    var getLogoInicio = "LogoInicio"
    var getAgenda = "AgendaDetalles"
    var getObtenerTelefono = "ObtenerTelefono"
    var getImagenNoticia = "ImagenNoticia"
    var getRutaFotos = "RutaFotos"
    var getGetNotify = "GetNotify"
    var getOrquesta = "Orquesta"
    var getPromocionesDia = "PromocionesDia"
    var getEventosSemana = "EventosSemana"
    var getBeneficiosSemana = "BeneficiosSemana"

    
    //metodo POST
    var postValidarDni = "ValidarDni"
    var postRegistro = "Registro"
    var postEliminarAgendado = "EliminarAgendado"
    var postGuardarEvento = "GuardarEvento"
    var postUpdateUserData = "UpdateUserData"
    var postUpdatePassword = "updatePassword"
    var postAddSesion = "addSesion"
    var postUpdateSession = "updateSession"
    var postSetToken = "GuardarToken"
    var postConfigNotificacion = "ConfigNotificacion"
    var postAgregarIngreso = "agregarIngreso"
    var getNovedades = "Novedades"
    var postAgregarActividadPromocion = "agregarActividadPromocion"
    var postAgregarActividadEvento = "agregarActividadEvento"
    var postAgregarActividadCobro = "agregarActividadCobro"
    var postHideNotify = "HideNotify"
    var postObtenerCodigo = "ObtenerCodigo"
    var postVerificarCodigo = "VerificarCodigo"
 
    //variable para guardar datos en rom
    var preferences : UserDefaults? = nil
    
    func getPreference() -> UserDefaults{
        if(preferences == nil){
            preferences = UserDefaults.standard
        }
        return preferences!
    }

    //object saves
    func saveFistInit(isFirst:Bool){
        getPreference().set(isFirst,forKey:"isFirst")
        getPreference().synchronize()
    }
    func getFirstInit()->Bool{
        return getPreference().object(forKey:"isFirst" ) as? Bool ?? true
    }
    
    
    func saveUsername(username:String){
        getPreference().set(username,forKey:"username")
        getPreference().synchronize()
    }
    func getUsername()->String{
        return getPreference().object(forKey:"username" ) as! String
    }
    
    func saveBody(isActive:Bool,key:String){
        getPreference().set(isActive,forKey:key)
        getPreference().synchronize()
    }
    
    func getBody(key:String)->Bool{
        return getPreference().object(forKey: key) as? Bool ?? false
    }
    
    func saveNotify(isActive:Bool){
        getPreference().set(isActive,forKey:"notify")
        getPreference().synchronize()
    }
    func getNotify()->Bool{
        return getPreference().object(forKey:"notify" ) as? Bool ?? false
    }
    
    
    func savePassword(password:String){
        getPreference().set(password,forKey:"password")
        getPreference().synchronize()
    }
    func getPassword()->String{
        return getPreference().object(forKey:"password" ) as! String
    }
    
    func saveLogin(isLogin:Bool){
        getPreference().set(isLogin,forKey:"isLogin")
        getPreference().synchronize()
    }
    func getLogin()->Bool{
        return getPreference().object(forKey:"isLogin" ) as? Bool ?? false
    }
    func saveTerminos(terminoState:Bool){
        getPreference().set(terminoState,forKey:"terminoState")
        getPreference().synchronize()
    }
    func getTerminos()->Bool{
        return getPreference().object(forKey: "terminosState") as? Bool ?? false
    }
    
    
}
