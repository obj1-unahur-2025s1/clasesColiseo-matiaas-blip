class ArmaFilo {
  const property filo 
  const property longitud  
  method ataque() {
    return filo * longitud
  }
}

class ArmaContundentes {
  const property peso 
  method ataque() {
    return peso
  } 
}

object casco {
  method armadura() {
    return 10
  }
}

object escudo {
  method armadura() {
    
  }
}

class Mirmillones {
  var property vida = 100
  var arma 
  var armadura
  const property destreza = 15
  var property fuerza  
  method elegirArma(unArma) {
    arma = unArma
  } 
  method cambiarArmadura(unaArmadura) {
    armadura = unaArmadura
  }
  method atacar(gladiador) {
    gladiador.vida(gladiador.vida() - gladiador.defensa() - (fuerza + arma.ataque()))
    gladiador.contraAtaque(self)
  }
  method defensa() {
    armadura + destreza
  }
  method contraAtaque(unGladiador) {
    unGladiador.vida(unGladiador.vida() - unGladiador.defensa() - self.poderDeAtaque())
  }
  method crearGrupo(gladiador) {
    const mirmillolandia = new Grupo(nombre = mirmillolandia)
    mirmillolandia.unirMiembro(gladiador)
    mirmillolandia.unirMiembro(self)
  }
  method poderDeAtaque() {
    return fuerza + arma.ataque()
  }
  method curar() {
    self.vida(100)
  }
}

class Dimachaerus {
  var property vida = 100 
  var property armas = #{}
  const property fuerza = 10
  var property destreza 
  method elegirArma(unArma) {
    armas = unArma
  } 
  method poderDeAtaque() {
    return fuerza + armas.sum({arma => arma.ataque()})
  }
  method atacar(gladiador) {
    gladiador.vida(gladiador.vida() - gladiador.defensa() - self.poderDeAtaque())
    destreza += 1
    gladiador.contraAtaque(self)
  }
  method defensa() {
    destreza / 2
  }
  method contraAtaque(unGladiador) {
    unGladiador.vida(unGladiador.vida() - unGladiador.defensa() - (fuerza + armas.sum({arma => arma.ataque()})))
    destreza += 1
  }
  method crearGrupo(gladiador) {
    const nombreGrupo = "D-" ++ (self.poderDeAtaque() + gladiador.poderDeAtaque()).toString()
    const grupo = new Grupo(nombre = nombreGrupo)
    nombreGrupo.unirMiembro(gladiador)
    nombreGrupo.unirMiembro(self)
  }
  method curar() {
    self.vida(100)
  }
}

class Grupo {
  var property nombre
  var peleas = 0
  var miembros = #{}
  method miembroQuePuedeCombatir() {
    miembros.find({ 
      miembro => miembro.vida() > 1 and miembro.max().fuerza()
    })
  }
  method unirMiembro(unMiembro) {
    miembros.add(unMiembro)
  }
  method quitarMiembro(unMiembro) {
    miembros.remove(unMiembro)
  }
  method pelearContraGrupo(contrincantes) {
    peleas =+ 1
    contrincantes.forEach({miembro => miembro.atacar(self)})
    miembros.forEach({miembro => miembro.atacar(contrincantes)})
  }
  method pelearContraGladiador(unGladiador) {
    peleas =+ 1
    unGladiador.atacar(self)
    miembros.forEach({miembro => miembro.atacar(unGladiador)})
  }
}

object coliseo {
  method organizarPeleaGrupal(unGrupo,otroGrupo) {
    unGrupo.pelearContraGrupo(otroGrupo)
    otroGrupo.pelearContraGrupo(unGrupo)
  }
  method organizarPelea(unGrupo,unGladiador) {
    unGrupo.pelearContraGladiador(unGladiador)
    unGladiador.atacar(unGrupo)
  }
  method curarGladiadores(gladiadores) {
     gladiadores.forEach({miembro => miembro.curar()})
  }
  method curarGladiadorSolitarios(gladiador) {
    gladiador.curar()
  }
}