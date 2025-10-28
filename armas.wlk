import wollok
class Torres{
    var nivel 
    var vida
    var velocidadAtaque
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
        }
    }
}