import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
object juegoDelCastillo {//para mantener la estructura del juego.
  var  property nivel = nivelPrueba
  method iniciar() {
    game.title("juego Del Castillo")
    game.height(10)
	  game.width(20)
    game.addVisual(torresOpciones)
    game.boardGround("fondo.png") //clase fondo para cambiar de niveles
    nivel.iniciar()
  }
}
class Castillo{
  //Las defensas y ataques mejor numeros altos (100 o 500) para facilitar las escalas y usar así siempre números enteros
  var defensa = nivelCastillo * 10
  var nivelCastillo = 1
  
  method subirNivel(){
    nivelCastillo = nivelCastillo + 1
  }
  
  method recibirDaño(nivelDaño){
    defensa = defensa - nivelDaño
  }
}


class Torre{
  var nivelTorre
  const costo
  const daño
  const rango
  const positionOpcion // direccion en la cual es  reflagada en el menu , esto para poder saber donde esta en el menu -> solo lo conoce la torre . 
  const diseñoTorre=["torre1.png","torre2.png"] //falta agregar mas imagenes ... 
  var imagen="torre.png"
  var property  position 
  method image() = imagen
  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }
  method elegirDiseño(num) {
    imagen=self.obtenerDiseñoDeLista(num) // num =torre Diseño -> numero , puede ser las diferentes torres,esto para facilitar la adicion de la imagen a la torre.
  }
  method obtenerDiseñoDeLista(num)=diseñoTorre.get(num) // es para obtener el diseño. (al hacerlos nosotros, ya deberiamos saber cuantos diseños hay, y asi no poener fuera del indice)
  method costo() =costo 
  method atacar() = daño + nivelTorre
  method asignarUbicacion(unaPosicion) {
    position=unaPosicion
    
  }
  method posicionDeOpcion() =positionOpcion 
  method cursor() ="cursorTorre.png" 
  method rangoEfectivo() {
    return [
      position.up(rango),position.down(rango),position.left(rango),position.right(rango), arriba.siguientePosicion(position.up(rango)),
      abajo.siguientePosicion(position.down(rango)),
      izquierda.siguientePosicion(position.left(rango)),
      derecha.siguientePosicion(position.right(rango))
    ]
  }

  //No estoy seguro si funcionara, pero me parece una forma rapida de saber si un enemigo esta en el rango de la torre
  method estaEnRango(unEnemigo) {
    game.schedule(1700, {self.rangoEfectivo().contains(unEnemigo.posicionActual()) })
    console.println(self.rangoEfectivo().contains(unEnemigo.posicionActual()))
    console.println(self.rangoEfectivo())
  }


}

object arriba {
  method siguientePosicion(pos) = pos.up(1)
}
object abajo {
  method siguientePosicion(pos) = pos.down(1)
}
object izquierda {
  method siguientePosicion(pos) = pos.left(1)
}
object derecha {
  method siguientePosicion(pos) = pos.right(1)
}

class Proyectil{
  //
  const daño
  var imagen
  var property position 
  const diseñoProyectil = []


  method obtenerDiseñoDeLista(num)=diseñoProyectil.get(num) 
  method elegirDiseño(num) {
    imagen=self.obtenerDiseñoDeLista(num) //Me lo robe por que puede servir muejejeje
  }

  method infligirDañoA(unEnemigo){
    unEnemigo.recibirDaño(daño)
  }

  method mover(direccion) {
    position = direccion.siguientePosicion(position)
  }

  method hayEnemigo(unEnemigo){
    return unEnemigo.position() == position
  }

  method viajarProyectilHacia(direccion, unEnemigo){
    if(self.hayEnemigo(unEnemigo)){
      self.infligirDañoA(unEnemigo)
    }
    else{
      self.mover(direccion)
    }
  }
}
