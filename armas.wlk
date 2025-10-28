import wollok
class Torre{
    var nivel 
    var vida
    var velocidadAtaque
    var rango
    var costo
    
    method estaVivo() = vida > 0
    
    method recibirAtaque(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
        }
    }
    
    method atacar(unObjeto, cantidadDaño){
        unObjeto.recibirDaño(cantidadDaño)
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