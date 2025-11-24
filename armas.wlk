import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*

class Torre{
  var nivelTorre
  const rango
  var torreActiva =true
  ///const costo
  const daño
  const positionOpcion // direccion en la cual es  reflagada en el menu , esto para poder saber donde esta en el menu -> solo lo conoce la torre . 
  const property  position 
  
  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }
  method posicionDeOpcion() =positionOpcion 

  method cursor() ="cursorTorre.png" 

    method rangoEfectivo() {
    return  [
        position.up(rango),position.down(rango),position.left(rango),position.right(rango), arriba.siguientePosicion(position.up(rango)),
        abajo.siguientePosicion(position.down(rango)),
        izquierda.siguientePosicion(position.left(rango)),
        derecha.siguientePosicion(position.right(rango)),
        izquierda.diagonalInferior(position),
        izquierda.diagonalSuperior(position),
        derecha.diagonalInferior(position),
        derecha.diagonalSuperior(position)
        ]
  }

  method atacarSiEstaEnRango(unEnemigo) {

    if(torreActiva and self.rangoEfectivo().contains(unEnemigo.post()) and unEnemigo.estaVivo())
        game.schedule(100, {unEnemigo.recibirDaño(self.atacar())})
  }
  method eliminar() {
    torreActiva=false
    game.removeVisual(self)

  }
  method image()
  method atacar() = daño + nivelTorre
  method costo()


}

class TorreNormal inherits Torre{
  override method costo() = 3
  override method image() = "torre1.png"
  //override method atacar() = super() + self.costo()
}

class TorreCañon inherits Torre{
  override method costo() = 5
  override method image() = "torre2.png"
  //override method atacar() = super() + self.costo()

}

class TorreTesla inherits Torre{
  override method costo() = 10
  override method image() = "torre3.png"
  //override method atacar() = super() + self.costo()
}


object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const opciones=[[1,3],[1,4],[1,5],[1,6]] //1,3 -> torre flecha // 1,4 -> torre cañon // 1,5 -> torre tesla // 1,6 -> eliminarTorre
    const torres=[]
    const torresExistentes=[]
    method image() ="cursor.png"
    var property position = game.at(1, 3) 
    
    method posicionActualComoColeccion() =[position.x(),position.y()] // "como coleccion" refiere a  la posicion que refleja dentro del menu, y esta la mete en una coleccion para luego comparar.
    method torreBuscada() =torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    method eliminarTorre(x,y) {
      if(self.esPosibleEliminar()){ //elimina la torre si es posible
        torresExistentes.filter({ t=>t.position().y() ==y and t.position().x() ==x  }).forEach({t => t.eliminar()}) //torres Existentes guarda multiples instancias de las torres. por ende se eliminan estas con el forEach.
        torresExistentes.removeAll( torresExistentes.filter({ t=>t.position().y() ==y and t.position().x() ==x  }))   //las torres que coincidan con la posicion de la celda actual. (del jugador)
      }                   // remover todas las torres existentes , para un eficiente borrado despues.
    }
    method esPosibleEliminar()  =  opciones.get(3) == self.posicionActualComoColeccion()                                                                                                          
    method torreSeleccionada(x, y) {
    torres.clear() // sirve para poder comparar las 3 torres creadas, ya con la posicion pasada por parametro, y esta sea comparada por ->  torreBuscada() 
    const normal = new TorreNormal(
        nivelTorre = 1,
        daño = 3,
        rango = 2,
        position = game.at(x, y),
        positionOpcion = opciones.get(0)
    )
    torres.add(normal)

    const canon = new TorreCañon(
        nivelTorre = 2,
        daño = 5,
        rango = 1,
        position = game.at(x, y),
        positionOpcion = opciones.get(1)
    )
    torres.add(canon)

    const tesla = new TorreTesla(
        nivelTorre = 3,
        daño = 20,
        rango = 1,
        position = game.at(x, y),
        positionOpcion = opciones.get(2)
    )
    torres.add(tesla)
    torresExistentes.add(self.torreBuscada())
    return self.torreBuscada()
}
    method posicionEliminar() =opciones.get(3)
    method partidaFinalizada() {
      if(torresExistentes.size()>0) torresExistentes.forEach({ t=> t.eliminar()})
      torresExistentes.clear()
    }
    method encontrarTorre() = torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    //movimientos de las torres, recomiendo dejar aca y no moverlo a controles para que sea mas entendible
    method moverseHaciaArriba() {
        if(self.position().y() >1 and self.position().y() <6 ){
		      self.position(self.position().up(1))
        }
        else{
            position=game.at(1,3)
        }
	  } 
    method moverseHaciaAbajo()  {
        if(self.position().y() >3){
		      self.position(self.position().down(1))
        }
        else{
            position=game.at(1,0)   
        }
	  }
}
