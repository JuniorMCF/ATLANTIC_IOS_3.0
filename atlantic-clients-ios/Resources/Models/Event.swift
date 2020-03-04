//
//  Event.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/7/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation

class Event: Hashable {
    var id = 0
    var eventoId = 0
    var clienteId = 0
    var nombre = ""
    var descripcion = ""
    var fecha = ""
    var nombreTipo = ""
    var foto = ""
    var esPrincipal = false
    var show = ""
    var video = ""
    var nroAcompañantes = ""
    var horarioId = 0
    var agendaId = 0
    var nombreCorto = ""
    var tituloShow = ""
    var nAcompanantes = ""
    var fotos : [FotoEvent] = []
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id &&
            lhs.eventoId == rhs.eventoId &&
            lhs.clienteId == rhs.clienteId &&
            lhs.nombre == rhs.nombre &&
            lhs.descripcion == rhs.descripcion &&
            lhs.fecha == rhs.fecha &&
            lhs.nombreTipo == rhs.nombreTipo &&
            lhs.foto == rhs.foto &&
            lhs.esPrincipal == rhs.esPrincipal &&
            lhs.show == rhs.show &&
            lhs.video == rhs.video &&
            lhs.nroAcompañantes == rhs.nroAcompañantes &&
            lhs.horarioId == rhs.horarioId &&
            lhs.agendaId == rhs.agendaId &&
            lhs.nombreCorto == rhs.nombreCorto &&
            lhs.tituloShow == rhs.tituloShow &&
            lhs.nAcompanantes == rhs.nAcompanantes
            //lhs.fotos == rhs.fotos
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(eventoId)
        hasher.combine(id)
        hasher.combine(eventoId)
        hasher.combine(clienteId)
        hasher.combine(nombre)
        hasher.combine(descripcion)
        hasher.combine(fecha)
        hasher.combine(nombreTipo)
        hasher.combine(foto)
        hasher.combine(esPrincipal)
        hasher.combine(show)
        hasher.combine(video)
        hasher.combine(nroAcompañantes)
        hasher.combine(horarioId)
        hasher.combine(agendaId)
        hasher.combine(nombreCorto)
        hasher.combine(tituloShow)
        hasher.combine(nAcompanantes)
        //hasher.combine(fotos)
    }

}

