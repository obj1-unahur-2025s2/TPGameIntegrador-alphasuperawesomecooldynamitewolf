import armas.*
import castillo.*
import wollok.game.*
class Enemigo{
    var vida
    var daño
    var rango
    method recibirDaño(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
            ///game.say("Me queda" + self.vida()) /// Revisar por las dudas
        }
        self.morir()
    }

    method vida() = vida
    
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
