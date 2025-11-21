import juegoBase.*
import armas.*
import enemigos.*
import wollok.game.*
import niveles.*

object castillo {
    var property position =game.at(8,0) 
    var vida = 100
    method image() ="castillo.png" //Y si vemos de meterle efectos como de "deteriorado" cuando esté por debajo del 50% de vida y al llegar a 0 antes de sacarte del juego que cambie la imagen a un cúmulo de ladrillos y despues diga "Perdiste" por ejemplo
    method activarColision(){
        game.onCollideDo( self,{enemigo=> enemigo.atacar(self)})
    }
    
    method recibirDaño(cantidad){
    vida -= cantidad
    game.say(self, "Me queda " + vida + " de vida")
    if(vida <= 0){
        juegoDelCastillo.partidaFinalizada()
    }
}

    
}


object personajePrincipal{
    var monedas = 6
    method posicionActual() =position 
    var nivel= nivelPrueba
    const  torres = []
    const property torresPuestas = []
    method agregarTorresPuestas(unaTorre) {
      torresPuestas.add(unaTorre)
    } 
    const  imagen="cursorTorre.png"
    method image() = imagen
    var property position =game.at(8,3) 
    method siguienteNivel(unNivel) {
      nivel=unNivel
    }

    //movimientos, dejar aca para evitar confusion con los de torres
    method moverseHaciaArriba() {
        const pos=nivel.ubicacionSiguienteA([position.x(),position.y()])
        position= game.at(pos.get(0), pos.get(1))
	}
	method moverseHaciaAbajo() {
		const pos =nivel.ubicacionAnterior()
        position=game.at(pos.get(0),pos.get(1))
    }
    //Metodos encargados del manejo de la economia

    method monedas() = monedas
    method puedePagar(costo) = monedas >= costo
    method gastarMonedas(unCosto){
        monedas = monedas - unCosto
    }
    method recogerMonedas(cantMonedas){monedas += cantMonedas} ///Actualizar
    //Todos los metodos relacionados al poner torres
    method torres() = torres
    method torreSeleccionada() =torresOpciones.torreSeleccionada(position.x(),position.y())
    method torreCosto() =self.torreSeleccionada().costo()  
    method sePuedeAgregarTorre() = not self.hayTorreEn(self.posicionActual()) && self.puedePagar(self.torreCosto())  && juegoDelCastillo.juegoCorriendo()
    
    method agregarTorre(){    
        if (juegoDelCastillo.juegoCorriendo() and self.sePuedeAgregarTorre() ){
            torres.add(self.torreSeleccionada())
            game.addVisual(self.torreSeleccionada())
            self.agregarTorresPuestas(self.torreSeleccionada())
            self.gastarMonedas(self.torreCosto())
        }
        
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
    if (torresPuestas.contains(unaTorre)){
        torres.remove(unaTorre)
        game.removeVisual(unaTorre)
    }
    }
    method partidaFinalizada() {
        torres.clear()
        monedas=6

    }
}