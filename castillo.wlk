import armas.*
import enemigos.*
import wollok.game.*
import niveles.*

object castillo {
    var vida = 100
    var property position =game.at(6, 0) 
    method image() ="castillo.png" //Y si vemos de meterle efectos como de "deteriorado" cuando esté por debajo del 50% de vida y al llegar a 0 antes de sacarte del juego que cambie la imagen a un cúmulo de ladrillos y despues diga "Perdiste" por ejemplo
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
    const torres = [] //Cual sería la ventaja de guardar la lista de torres en el mapa en vez de evaluar en el momento de la acción (poner, mejorar, sacar) si hay una instancia de clase torre en la posición? Y delegar que hace en casa caso a cada función.
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
    //Algo como esto, así de simple se puede hacer para los ataques a los enemigos. Si se hace los de la imagen con transparencia que puse en el otro archivo



    ///Estos dos metodos agregue
    method monedas() = monedas
    method botin(valor){monedas += valor}

    method adaptar(algo) {
        imagen=algo.cursor()
    }
    method siguienteNivel(unNivel) {
      nivel=unNivel
    }

    //Se puede utilizar el toString para pasar de nivel. Entonces al invocarlo es nivel + toString o algo así y los niveles se llaman nivel1, nivel2, etc.

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

    method hayTorreEn(positionActual) = torres.any({ t => t.position() == positionActual }) //Con esto se puede simplificar sin necesidad de tener una lista de torres en el jugador. No es necesario si evaluas en la acción directamente

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