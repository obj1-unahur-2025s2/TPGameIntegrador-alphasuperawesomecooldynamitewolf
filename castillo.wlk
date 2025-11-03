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


object personajePrincipal{
    var monedas = 10
    var nivel= nivelPrueba
    const torres = []
    var imagen="cursorTorre.png"
    method image() =imagen
    var property position =game.at(8,3) 
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
        position= game.at(pos.get(0), pos.get(1))
        self.sensar()
	}
	method moverseHaciaAbajo() {
		const pos =nivel.ubicacionAnterior()
        position=game.at(pos.get(0),pos.get(1))
        self.sensar()
    }
    //opciones torres -> es agarrado del menu de opciones //ver si es correcto hacerlo asi.
    method puedePagar(costo) = monedas >= costo
    method torreSeleccionada() =torresOpciones.torreSeleccionada(position.x(),position.y())
    method torreCosto() =self.torreSeleccionada().costo()  
    method posicionActual() =position 
    method sePuedeAgregarTorre() = not self.hayTorreEn(self.posicionActual()) && self.puedePagar(self.torreCosto())
    
    
    method agregarTorre(){    
        if (self.sePuedeAgregarTorre()){
            torres.add(self.torreSeleccionada())
            game.addVisual(self.torreSeleccionada())
            self.gastarMonedas(self.torreCosto())
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