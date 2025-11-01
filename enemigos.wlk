import armas.*
import castillo.*
import wollok.game.*
import niveles.torresOpciones

//const enemigo1 = new Enemigo(posiciones = nivelPrueba.ubicacionesCamino()) Ejemplo de como tendría que ser la instanciación de los enemigos con los demas atributos

class Enemigo{
    var vida //diferencias de vidas y hits
    var daño
    var rango
    var imagen
    const posiciones
    const nivelAct
    var property position =game.at(0, 0)
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
            game.schedule(1200, { self.avanzar()}) // activa recursion
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

class JefeFinal inherits Enemigo{
    
}
//para ver posiciones, borrar si hace falta:
object map {
  var property position =game.at(14,5) //14,5
  method image() ="idlTroll.png" 
}