import castillo.*

import niveles.*
import wollok.game.*
object juegoDelCastillo {//para mantener la estructura del juego.
  var  property nivel = nivelPrueba
  method iniciar() {
    game.title("juego Del Castillo")
    game.height(10)
	  game.width(20)
    game.addVisual(cursorMenu)
    game.boardGround("fondo.png")
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
  method cursor() ="cursorTorre.png" 
}

//Los Stats de los enemigos luego resolvemos como automatizar la creación y parametrización para polimorfizarlo de nivel a nivel
class EnemigoBase{
  //El nivel de juego luego resolvemos como pasárlo para parametrizar y automatizarlo al pasar de nivel
  const nivelEnemigo = juego.nivelJuego() * 2
  const daño
  var vida

  method recibirDaño(nivelDeDaño){
    vida = vida - nivelDeDaño
  }

  method atacar() = daño + nivelEnemigo
}

class EnemigoJefe{
  const nivelEnemigo = juego.nivelJuego() * 2
  const daño //Algún multiplicador respecto a los EnemigosBase
  var vida //Algún multiplicador respecto a los EnemigosBase

  method recibirDaño(nivelDeDaño){
    vida = vida - nivelDeDaño
  }

  method atacar() = daño * nivelEnemigo
}

