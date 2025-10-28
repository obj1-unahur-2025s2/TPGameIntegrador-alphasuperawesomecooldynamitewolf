import armas.*
import castillo.*

class Enemigo{
    var vida
    var daño
    var rango
    method recibirDaño(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
        }
    }

    method estaVivo() = vida > 0
    
    method atacar(unObjeto, cantidadDaño){
        unObjeto.recibirDaño(cantidadDaño)
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

    method atacar(unObjeto, cantidadDaño){
        unObjeto.recibirDaño(cantidadDaño)
    }

    method estaVivo() = vida > 0
}
