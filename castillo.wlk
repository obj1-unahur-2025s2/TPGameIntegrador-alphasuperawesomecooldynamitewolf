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
    method cursor()="cursorCastillo.png" //polimorfismo en las estructura asi el cursor sabe como adaptarse 
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
    var nivel= nivelPrueba
    const torres = []
    var imagen="cursorCastillo.png"
    method image() =imagen
    var property position = game.at(6, 0) 
    //secuencia del cursor y estrucutura de nivel
    method sensar() {
      	game.onCollideDo(
		self,
		{ algo =>
			self.adaptar(algo)
		}
	)
    }
    ///Estos dos metodos agregue
    method monedas() = monedas
    method botin(valor){monedas += valor}

    method adaptar(algo) {
        imagen=algo.cursor()
    }
    method siguienteNivel(unNivel) {
      nivel=unNivel
    }

    //movimientos
    method moverseHaciaArriba() {
        const pos=nivel.ubicacionSiguienteA([position.x(),position.y()])
        console.println(pos)
        imagen="cursorTorre.png"
        position= game.at(pos.get(0), pos.get(1))
		console.println(position)
        self.sensar()
	}
	method moverseHaciaAbajo() {
		const pos =nivel.ubicacionAnterior([position.x(),position.y()])
        position=game.at(pos.get(0),pos.get(1))
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

class Moneda {
  var property valor
  var property position
  method image(){} 
  method moneda(){
    personajePrincipal.botin(valor)
    game.say(personajePrincipal,"Tengo" + personajePrincipal.monedas() + "Monedas")
  }
}