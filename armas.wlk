import wollok
class Torre1{
    var nivel 
    var vida
    var velocidadAtaque
    var rango
    var costo
    var daño
    var position 

    method estaVivo() = vida > 0
    
    method recibirAtaque(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
            ///game.say("Me queda" + self.vida()) /// Revisar por las dudas
        }
        ///self.morir()
    }
    /*method morir(){
        if(!self.estaVivo()){

        }
    }*/

    method position() = position

    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
        game.say(unObjeto, "Me queda" + unObjeto.vida()) /// Revisar por las dudas

    }
    
    method nivelMaximo() = nivel == 3
    
    method subirNivel(){
        if(!self.nivelMaximo()){
            nivel += 1
            velocidadAtaque = 5
            costo = 20 
        }
    }
    
    method costo() = costo
    
    method costoMejora() = costo * 2 
}
