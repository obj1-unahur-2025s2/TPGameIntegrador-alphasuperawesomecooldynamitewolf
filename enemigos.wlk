class Enemigos{
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
}

