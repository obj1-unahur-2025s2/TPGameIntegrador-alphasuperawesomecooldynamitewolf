import armas.*
import enemigos.*
object castillo {
    var vida = 100
    method recibirDaño(cantidadDaño){
        if(self.estaVivo())
        vida -= cantidadDaño
    }
    
    method estaVivo() = vida > 0
    
    method estaDestruido() = !self.estaVivo()
}

object personajePrincipal{
    var monedas = 0
    const torres = []
    method puedePagar(costo) = monedas >= costo

    method agregarTorre(torre){
        if(self.puedePagar(torre.costo())){ ///Faltaria agregar que no haya una torre en la ubicacion actual y un par de cosas mas 
            const nuevaTorre = new Torre(nivel = 1, vida = 50 ,velocidadAtaque = 10, rango = 2 ,costo = 50) /// Lo puse como para tener una idea de como seria
            torres.add(torre)
            monedas -= torre.costo()
        }
    }
    
    method mejorarTorre(unaTorre){
        if (torres.contains(unaTorre) && self.puedePagar(unaTorre.costoMejora())) {
            unaTorre.subirNivel()
            monedas -= unaTorre.costoMejora()
        }
    }

    method eliminarTorre(unaTorre){
    if (torres.contains(unaTorre)){
        torres.remove(unaTorre)
        }
    }

    method recogerMonedas(enemigo){monedas += enemigo.valor()}
}