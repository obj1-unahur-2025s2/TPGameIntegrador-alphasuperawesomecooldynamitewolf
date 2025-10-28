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
     ///self.morir()
    }
    /*method morir(){
        if(!self.estaVivo()){

        }
    }*/


    method estaVivo() = vida > 0
    
    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
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
