object castillo {
    var vida = 100
    method recibirDaño(cantidadDaño){
        if(self.estaVivo())
        vida -= cantidadDaño
    }
    method estaVivo() = vida > 0
}