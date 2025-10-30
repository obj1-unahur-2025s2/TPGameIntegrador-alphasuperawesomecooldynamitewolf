import armas.*
import castillo.*
import wollok.game.*
import niveles.torresOpciones

class Enemigo{
    var vida
    var daño
    var rango
    var imagen
    var property position =game.at(0, 0)
    const posiciones=[[19,5],[18,5],[17,5],[17,4],[17,3],[17,2],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[9,1]] //mapeo //14,5
    const posicioActual=[]
    method posicionActual() = game.at(posicioActual.last().get(0),posicioActual.last().get(1))
    method recibirDaño(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
            ///game.say("Me queda" + self.vida()) /// Revisar por las dudas
        }
        self.morir()
    }

    method vida() = vida
    method image() =imagen
    method iniciar() {
        self.avanzar()
       
    } 
    method avanzar() {
        if(posiciones.size() !=0){//caso base, ya no hay posiciones.
            position=game.at(posiciones.first().get(0),posiciones.first().get(1)) // obtiene la primera posicion a la cual debe ir
            posicioActual.add([position.x(),position.y()]) // agrega esa posiciosion -> por si la torreta quiere saber donde está , sirve esto , solo falta un  getter
            posiciones.remove(posiciones.first()) // remueve su priemra posicion
            game.schedule(1700, { self.avanzar(); console.println(posicioActual.last())}) // activa recursion
        }
    }
    method morir(){
        if(!self.estaVivo()){
        game.removeVisual(self)
        self.soltarMoneda()
        }
    }
    ///Hay que ponerle un limite de que parte del juego deberia aparecer aleatoriamente
    method soltarMoneda(){
    const posMoneda = game.at(
    (0..game.width()-1).anyOne(),
    (0..game.height()-1).anyOne())

    const moneda = new Moneda(valor = self.valor(), position = posMoneda)
    game.addVisual(moneda)
    }

    method estaVivo() = vida > 0
    
    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
        game.say(unObjeto, "Me queda" + unObjeto.vida()) /// Revisar por las dudas
    }
    
    method valor() = 50 
    
}

///Opcion un jefe final poderoso, lo hago objeto por que es uno solo por el momento 

object jefeFinal{
    var vida = 1000 
    const daño = 50

    method recibirDaño(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
        }
    }

    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
    }

    method estaVivo() = vida > 0
}
//para ver posiciones, borrar si hace falta:
object map {
  var property position =game.at(14,5) //14,5
  method image() ="idlTroll.png" 
}