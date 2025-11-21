import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*
import armas.*
import intro.*


object juego {
  method iniciar() {
    game.title("Orcs defense")
    game.height(10)
    game.width(20)
    game.boardGround("fondo.png")
    game.addVisual(secuencia)
    secuencia.saltar()
    game.start()
    
  } 
}

object juegoDelCastillo {//para mantener la estructura del juego. <- primero debe pasar por el menu
  const sonido = game.sound("orcsAttacking.mp3")
  var  property nivel = nivelPrueba
  var juegoCorriendo=false //indicacion para los controles. si el juego todavia no iicio configura las teclas.
  const niveles=[]
  const nivelesCompeltos=[]
 
  method agregarNiveles(unNivel) {
    if(!niveles.contains(unNivel)){
      niveles.add(unNivel)
    }
  }
  method vaciarNiveles() {
    niveles.clear()
    console.println(" VACIE niveles")
    console.println(niveles)
  } 
  method tieneNiveles() =niveles.size()>0 //util para teclas del selector nivel. impide que se agreguen multiple veces los niveles. (revisar Menu) 
  method iniciarNivel() {
    sonido.shouldLoop(true)
    sonido.play()
    controles.configurarTeclas()
    juegoCorriendo=true  //las teclas no se van a volver a iniciar. (sin las teclas sumas movimietos no previstos.)
    if(!game.hasVisual(torresOpciones)) game.addVisual(torresOpciones) //se pregunta porque juegoDelCastillo es un objeto que no muere. por ende es propenso a insertar multiple veces el menu.
    console.println(niveles)
    self.obtenerNivel().iniciar()

  }
   
  method obtenerNivel() = niveles.first()
  method pasarDeNivel() {
    nivelesCompeltos.add(nivel)
    niveles.remove(nivel)
    nivel=self.obtenerNivel()
  }

  method reiniciarPartida() { sonido.shouldLoop(true) sonido.play()if(self.tieneNiveles()){self.obtenerNivel().reiniciarPartida()}} 
  method juegoCorriendo() =juegoCorriendo 
  method partidaFinalizada() { //le indica al menu de torres de opcion que su partida finalizo, y selecciona el primer nivel y habilita su manera de perder el nivel (parando y eliminando.)  
    sonido.stop()
    torresOpciones.partidaFinalizada() 
    self.obtenerNivel().partidaFinalizada()
    self.generarGameOver() //llama al menu GameOver para que vuevla con una pantalla.
  }  
  method generarGameOver() {if(!game.hasVisual(menuGameOver))game.addVisual(menuGameOver) menuGameOver.seleccionNivel() personajePrincipal.partidaFinalizada()}
   method nivelQueSigue()= niveles.filter({ n => nivelesCompeltos.any({ nc => n !=nc})}).first() // filtrame por los niveles que no están dentro de los niveles pasados por el jugador
  method borrarTodo(){
    personajePrincipal.partidaFinalizada()

  }
  
  method ganarPartida() {
    if(nivel.partidaGanada()){
      personajePrincipal.partidaFinalizada()
      self.pasarDeNivel()
      self.iniciarNivel()
    }
  }
}