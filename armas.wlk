import wollok
class Torre{
    var nivel 
    var vida
    var velocidadAtaque
    var rango
    var costo
    var daño
    
    method estaVivo() = vida > 0
    
    method recibirAtaque(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
        }
        ///self.morir()
    }
    /*method morir(){
        if(!self.estaVivo()){

        }
    }*/

    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
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