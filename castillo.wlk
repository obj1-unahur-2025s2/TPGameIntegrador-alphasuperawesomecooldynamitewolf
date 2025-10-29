import armas.*
import enemigos.*
import wollok.game.*
import niveles.*
object castillo {
    var vida = 100
    var property position =game.at(6, 0) 
    method image() ="castillo.png" 
    method recibirDaño(cantidadDaño){
        if(self.estaVivo())
        vida -= cantidadDaño
     ///self.morir()
    }
    
    /*method morir(){
        if(!self.estaVivo()){

        }
    }*/

    
    method estaVivo() = vida > 0
    method cursor()="cursor.png" //polimorfismo en las estructura asi el cursor sabe como adaptarse 
    method estaDestruido() = !self.estaVivo()
}

object cursorMenu {
  method image() ="cursor.png"
  var property position = game.at(1, 3) 
    method sensar() {
        game.onCollideDo(
		self,
		{ algo =>
            
		}   //adaptarlo despues.
	    )
    }
    //movimientos
    method moverseHaciaArriba() {
        if(self.position().y() <6 )
		self.position(self.position().up(1))
        self.sensar()
	}
    method moverseHaciaAbajo()  {
        if(self.position().y() >3)
		self.position(self.position().down(1))
        self.sensar()
	}

}
object personajePrincipal{
    var monedas = 10
    const torres = []
    var imagen="cursor12.png"
    method image() =imagen
    var property position = game.at(6, 0) 
    //secuencia del cursor
    method sensar() {
      	game.onCollideDo(
		self,
		{ algo =>
			self.adaptar(algo)
		}
	)
    }
    method adaptar(algo) {
        imagen=algo.cursor()
    }

    //movimientos
    method moverseHaciaArriba() {
		self.position(self.position().up(1))
        self.sensar()
	}
	method moverseHaciaAbajo() {
		self.position(self.position().down(1))
        self.sensar()
	}
	method moverseHaciaDerecha() {
		self.position(self.position().right(1))
        self.sensar()
	}
	method moverseHaciaIzquierda() {
		self.position(self.position().left(1))
        self.sensar()
	}

    method puedePagar(costo) = monedas >= costo
    
    method agregarTorre(torre){
        const costo = torre.costo()
        const posicion = self.position()
        if (not self.hayTorreEn(posicion) && self.puedePagar(costo)){
            torres.add(torre)
            torre.asignarUbicacion(posicion)
            game.addVisual(torre)
            self.gastarMonedas(costo)
        }
        
    }

    method gastarMonedas(unCosto){
        monedas = monedas - unCosto
    }

    method hayTorreEn(positionActual) = torres.any({ t => t.position() == positionActual })

    method mejorarTorre(unaTorre){
        const costo = unaTorre.costoMejora()
        if (torres.contains(unaTorre) && self.puedePagar(costo)) {
            unaTorre.subirNivel()
            self.gastarMonedas(costo)
        }
    }

    method eliminarTorre(unaTorre){
    if (torres.contains(unaTorre)){
        torres.remove(unaTorre)
        game.removeVisual(unaTorre)
        }
    }

    method recogerMonedas(enemigo){monedas += enemigo.valor()} ///Actualizar
}