import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*
import armas.*


object juego {
  method iniciar() {
    game.title("Orcs defense")
    game.height(10)
    game.width(20)
    game.boardGround("fondo.png")

    game.addVisual(menu)
    menu.seleccionNivel()
    game.start()
    
  } 
}

object juegoDelCastillo {//para mantener la estructura del juego. <- primero debe pasar por el menu
  var  property nivel = nivelPrueba
  var juegoCorriendo=true
  const niveles=[]
  const nivelesCompeltos=[]

  method agregarNiveles(unosNiveles) {
    niveles.add(unosNiveles)
  }
  method vaciarNiveles() {
    niveles.forEach({n => n.reiniciarPartida()})
    niveles.clear()
    console.println(" VACIE niveles")
    console.println(niveles)
  } 
  method iniciarNivel() {
    if(!game.hasVisual(torresOpciones)) game.addVisual(torresOpciones)
    controles.configurarTeclas()
    console.println(niveles)
    self.obtenerNivel().iniciar()

  }
  method obtenerNivel() = niveles.first()
  method pasarDeNivel() {
    nivelesCompeltos.add(nivel)
    nivel=self.nivelQueSigue()
  }
  method volverAlMenu() {juegoCorriendo=true ; }
  method reiniciarPartida() {juegoCorriendo=true ; self.obtenerNivel().reiniciarPartida()} 
  method juegoCorriendo() =juegoCorriendo 
  method perderPartida() {self.obtenerNivel().perderPartida(); juegoCorriendo=false; if(!game.hasVisual(menuGameOver))game.addVisual(menuGameOver);menuGameOver.seleccionNivel()} 
  method nivelQueSigue()= niveles.filter({ n => nivelesCompeltos.any({ nc => n !=nc})}).first() // filtrame por los niveles que no están dentro de los niveles pasados por el jugador
}

/*
class Torre{
  var nivelTorre
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

  method atacarEnemigo(unEnemigo) {
    console.println("PROBANDO")
    unEnemigo.recibirDaño(self.atacar())
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
    method torreSeleccionada(pos) {
        torres.clear() //<- elimina para poder crear repeticion. 
        const torreNormal=new Torre(nivelTorre=1,costo=2,daño=10,position=game.at(izquierda.diagonalInferior(pos).get(0),izquierda.diagonalInferior(pos).get(1)),positionOpcion=opciones.get(0)) //al iniciar las opciones se guardan en la lista las torres. No tocar bajo ninguna circunstancia
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=4,daño=15,position=game.at(izquierda.diagonalInferior(pos).get(0),izquierda.diagonalInferior(pos).get(1)),positionOpcion=opciones.get(1))//No tocar bajo ninguna circunstancia
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)
        return torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    }  
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
*/
