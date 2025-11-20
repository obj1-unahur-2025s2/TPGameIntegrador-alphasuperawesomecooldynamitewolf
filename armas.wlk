import wollok //No se que se estaría importando.
import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*

class Torre{
  var nivelTorre
  const rango
  ///const costo
  const daño
  const positionOpcion // direccion en la cual es  reflagada en el menu , esto para poder saber donde esta en el menu -> solo lo conoce la torre . 
  ///const diseñoTorre=["torre1.png","torre2.png","torre3.png"] //falta agregar mas imagenes ... 
///  var imagen="torre.png"
  const property  position 

///  method image() = self.diseño()
  
  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }
  /*method elegirDiseño(num) {
    imagen=self.obtenerDiseñoDeLista(num) // num =torre Diseño -> numero , puede ser las diferentes torres,esto para facilitar la adicion de la imagen a la torre.
  }
  method obtenerDiseñoDeLista(num)=diseñoTorre.get(num) // es para obtener el diseño. (al hacerlos nosotros, ya deberiamos saber cuantos diseños hay, y asi no poener fuera del indice)
  */
  method posicionDeOpcion() =positionOpcion 

  method cursor() ="cursorTorre.png" 

    method rangoEfectivo() {
    return [
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
    if(self.rangoEfectivo().contains(unEnemigo.post()) and unEnemigo.estaVivo())
        game.schedule(1700, {unEnemigo.recibirDaño(self.atacar())})
  }
  method eliminar() {
    game.removeVisual(self)
    console.println("intento de eliminar")
  }
  method image() = self.diseño()
  method diseño()
  method atacar() = daño + nivelTorre
  method costo()


}

class TorreNormal inherits Torre{
  override method costo() = 3
  override method diseño() = "torre1.png"
  //override method atacar() = super() + self.costo()
}

class TorreCañon inherits Torre{
  override method costo() = 5
  override method diseño() = "torre2.png"
  //override method atacar() = super() + self.costo()

}

class TorreTesla inherits Torre{
  override method costo() = 8
  override method diseño() = "torre3.png"
  //override method atacar() = super() + self.costo()
}


object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const opciones=[[1,3],[1,4],[1,5]] //1,3 -> torre flecha // 1,4 -> torre cañon // 1,5 -> torre tesla
    const torres=[]
    const torresExistentes=[]
    method image() ="cursor.png"
    var property position = game.at(1, 3) 
    
    method posicionActualComoColeccion() =[position.x(),position.y()] // "como coleccion" refiere a  la posicion que refleja dentro del menu, y esta la mete en una coleccion para luego comparar.
    method torreBuscada() = torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})

    //metodo el cual genera torres, las cuales deben recibir por parametro la posicion asi son colocadas, (es posible que se generen varias constantes, como que no. porque son eliminadas al iniciar. )
    /*method torreSeleccionada(x,y) {
        torres.clear() //<- elimina para poder crear repeticion. 
        const torreNormal= new TorreNormal(nivelTorre=1, daño=3,rango=2,position=game.at(x,y),positionOpcion=opciones.get(0)) //al iniciar las opciones se guardan en la lista las torres 
        ///torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        
        const torreCañon=new TorreCañon(nivelTorre=2,daño=15,rango=1,position=game.at(x,y),positionOpcion=opciones.get(1))
        ///torreCañon.elegirDiseño(1)
        torres.add(torreCañon)

        const torreTesla=new TorreTesla(nivelTorre=3, daño=20, rango=1,position=game.at(x,y),positionOpcion=opciones.get(2))
        ///torreTesla.elegirDiseño(2)
        torres.add(torreTesla)
        torresExistentes.add(self.torreBuscada())
        return self.torreBuscada()    
    } */ 

    method torreSeleccionada(x, y) {
    torres.clear()

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
        daño = 15,
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

    /*const seleccionada = torres.find({
        t => t.posicionDeOpcion() == self.posicionActualComoColeccion()
    })

    if (seleccionada != null) {
        game.addVisual(seleccionada)
        torresExistentes.add(seleccionada)
    }*/

    return torres.find({
        t => t.posicionDeOpcion() == self.posicionActualComoColeccion()
    })
}

    method partidaFinalizada() {
      torresExistentes.forEach({ t=> game.removeVisual(t)})
    }
    method encontrarTorre() = torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    method obtenerTorreNormal() = torres.get(0)
    method obtenerTorreCañon() = torres.get(1)
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
