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

  var  property nivel = 0//Numero
  var juegoCorriendo=false //indicacion para los controles. si el juego todavia no iicio configura las teclas.
  const niveles=[nivel1 , nivel2 , nivel3]
  const nivelesCompeltos=[]
  const sonido = game.sound("orcsAttacking.mp3")
  method agregarNiveles(unNivel) {
    if(!niveles.contains(unNivel)){
      niveles.add(unNivel)
    }
  }

  method tieneNiveles() =niveles.size()>0 //util para teclas del selector nivel. impide que se agreguen multiple veces los niveles. (revisar Menu) 
  method iniciarNivel(unNivel) { 
    game.clear()
    sonido.play()
    sonido.shouldLoop(true)
    nivel=unNivel
    controles.configurarReglas()
    controles.configurarTeclas()
    juegoCorriendo=true  //las teclas no se van a volver a iniciar. (sin las teclas sumas movimietos no previstos.)
    game.addVisual(torresOpciones) //se pregunta porque juegoDelCastillo es un objeto que no muere. por ende es propenso a insertar multiple veces el menu.
    self.obtenerNivel(unNivel).iniciar()

  }
  method nivelActual() =niveles.get(nivel) 
  method obtenerNivel(unNivel) = niveles.get(unNivel.min(2))

  method reiniciarPartida() {  // reinicia  enteramente la partida.
    game.clear()
    self.iniciarNivel(nivel)

  } 
  method juegoCorriendo() =juegoCorriendo 
  method partidaFinalizada() { //le indica al menu de torres de opcion que su partida finalizo, y selecciona el primer nivel y habilita su manera de perder el nivel (parando y eliminando.)  
    sonido.stop()
    self.obtenerNivel(nivel).partidaFinalizada()
    castillo.reiniciarVida()
    torresOpciones.partidaFinalizada()     
    game.removeVisual(torresOpciones)
    self.generarGameOver() //llama al menu GameOver para que vuevla con una pantalla.
  }  
  method ganarPartida() { //metodo el cual llama el rey orco al morir, esté despues llama al menu nextLvel
    sonido.stop()
    torresOpciones.partidaFinalizada() 
    self.obtenerNivel(nivel).partidaFinalizada()
    game.removeVisual(personajePrincipal)
    game.removeVisual(torresOpciones)
    personajePrincipal.partidaFinalizada()
    castillo.reiniciarVida()  
    menuNextLevel.seleccionNivel()
  }
  method partidaNueva() { //si en el menu Next Level se tocó la Tecla E , se carga la siguiente partida.
    self.iniciarNivel(self.irAsiguienteNivel())
    
  }
  method generarGameOver() {if(!game.hasVisual(menuGameOver))game.addVisual(menuGameOver) menuGameOver.seleccionNivel() personajePrincipal.partidaFinalizada()} // genera el menu game over
   method nivelQueSigue()= niveles.filter({ n => nivelesCompeltos.any({ nc => n !=nc})}).first() // filtrame por los niveles que no están dentro de los niveles pasados por el jugador
  method irAsiguienteNivel(){
    nivel = (nivel + 1).min(2)
    return nivel
  }
}