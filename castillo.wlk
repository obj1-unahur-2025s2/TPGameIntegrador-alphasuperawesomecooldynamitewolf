import armas.*
import enemigos.*
import wollok.game.*
import niveles.*
object castillo {
    var vida = 100
    var property position =game.origin() 
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


object personajePrincipal{
    var monedas = 10
    const torres = []
    var imagen="cursor.png"
    method image() =imagen
    var property position =game.origin() 
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
		self.position(self.position().up(4))
        self.sensar()
	}
	method moverseHaciaAbajo() {
		self.position(self.position().down(4))
        self.sensar()
	}
	method moverseHaciaDerecha() {
		self.position(self.position().right(4))
        self.sensar()
	}
	method moverseHaciaIzquierda() {
		self.position(self.position().left(4))
        self.sensar()
	}

    method puedePagar(costo) = monedas >= costo
    
    method agregarTorre(torre){
        ///Faltaria agregar que no haya una torre en la ubicacion actual y un par de cosas mas 
        //const nuevaTorre = new Torre(nivel = 1, vida = 50 ,velocidadAtaque = 10, rango = 2 ,costo = 50, daño = 10, position = 8) /// Lo puse como para tener una idea de como seria
        const costo = torre.costo()
        if (not self.hayTorreEn(self.position()) && self.puedePagar(costo)){
            torres.add(torre)
            torre.asignarUbicacion(self.position())
            game.addVisual(torre)
            self.gastarMonedas(costo)
        }
        
    }

    method gastarMonedas(unCosto){
        monedas = monedas - unCosto
    }

    method hayTorreEn(positionActual) = torres.any({ t => t.position() == positionActual })

    method mejorarTorre(unaTorre){
        if (torres.contains(unaTorre) && self.puedePagar(unaTorre.costoMejora())) {
            unaTorre.subirNivel()
            monedas -= unaTorre.costoMejora()
        }
    }

    method eliminarTorre(unaTorre){
    if (torres.contains(unaTorre)){
        torres.remove(unaTorre)
        }
    }
    
    method recogerMonedas(enemigo){monedas += enemigo.valor()}
}