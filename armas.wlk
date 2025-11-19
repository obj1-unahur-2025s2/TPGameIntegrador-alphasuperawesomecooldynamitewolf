import wollok //No se que se estaría importando.
import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*

class Torre{
  var nivelTorre
  const rango
  const costo
  const daño
  const positionOpcion // direccion en la cual es  reflagada en el menu , esto para poder saber donde esta en el menu -> solo lo conoce la torre . 
  const diseñoTorre=["torre1.png","torre2.png"] //falta agregar mas imagenes ... 
  var imagen="torre.png"
  const property  position 
  method image() = imagen
  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }
  method elegirDiseño(num) {
    imagen=self.obtenerDiseñoDeLista(num) // num =torre Diseño -> numero , puede ser las diferentes torres,esto para facilitar la adicion de la imagen a la torre.
  }
  method obtenerDiseñoDeLista(num)=diseñoTorre.get(num) // es para obtener el diseño. (al hacerlos nosotros, ya deberiamos saber cuantos diseños hay, y asi no poener fuera del indice)
  method costo() =costo 
  method atacar() = daño + nivelTorre
  method posicionDeOpcion() =positionOpcion 
  method cursor() ="cursorTorre.png" 

    method rangoEfectivo() {
    return [
        position.up(rango),position.down(rango),position.left(rango),position.right(rango), arriba.siguientePosicion(position.up(rango)),
        abajo.siguientePosicion(position.down(rango)),
        izquierda.siguientePosicion(position.left(rango)),
        derecha.siguientePosicion(position.right(rango)),
        izquierda.diagonalInferior(position),
        izquierda.diagonalSuperior(position),
        derecha.diagonalInferior(position),
        derecha.diagonalSuperior(position)
        ]
  }

  method atacarSiEstaEnRango(unEnemigo) {
    if(self.rangoEfectivo().contains(unEnemigo.post()) and unEnemigo.estaVivo())
        game.schedule(1700, {unEnemigo.recibirDaño(self.atacar())})
  }

}

object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const opciones=[[1,3],[1,4]] //1,3 -> torre flecha // 1,4 -> torre cañon
    const torres=[]

    method image() ="cursor.png"
    var property position = game.at(1, 3) 
    
    method posicionActualComoColeccion() =[position.x(),position.y()] // "como coleccion" refiere a  la posicion que refleja dentro del menu, y esta la mete en una coleccion para luego comparar.
    
    //metodo el cual genera torres, las cuales deben recibir por parametro la posicion asi son colocadas, (es posible que se generen varias constantes, como que no. porque son eliminadas al iniciar. )
    method torreSeleccionada(x,y) {
        torres.clear() //<- elimina para poder crear repeticion. 
        const torreNormal=new Torre(nivelTorre=1,costo=2,daño=10,rango=2,position=game.at(x,y),positionOpcion=opciones.get(0)) //al iniciar las opciones se guardan en la lista las torres 
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=4,daño=15,rango=1,position=game.at(x,y),positionOpcion=opciones.get(1))
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)
        return torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    }  
    method encontrarTorre() = torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    method obtenerTorreNormal() = torres.get(0)
    method obtenerTorreCañon() = torres.get(1)
    //movimientos de las torres, recomiendo dejar aca y no moverlo a controles para que sea mas entendible
    method moverseHaciaArriba() {
        if(self.position().y() >1 and self.position().y() <6 ){
		self.position(self.position().up(1))
        }
        else{
            position=game.at(1,3)
        }
	  } 
    method moverseHaciaAbajo()  {
        if(self.position().y() >3){
		self.position(self.position().down(1))
        }
        else{
            position=game.at(1,0)   
        }
	  }
}
/*class Torre1{
    var nivel 
    var vida
    var velocidadAtaque
    var rango
    var costo
    var daño
    var position 

    method estaVivo() = vida > 0
    

    //Se puede sacar el "recibir ataque" ya que no va a estar implementado. No lo saco por si algo depende por algún motivo de esto. No quiero romper el código
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
    }

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
*/
