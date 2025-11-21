// //Copié todo lo relacionado a controles acá... no discriminé nada.. Despues lo pulimos para usarlos desde aca. Por ahora no quiero romper nada. Por eso no toco nada del codigo real.
import menu.*
import juegoBase.*
import castillo.*
import niveles.*
import armas.*
import intro.*

object controles {
    method configurarTeclas() {
      if(!juegoDelCastillo.juegoCorriendo()){ // si el juego  todavía no inició, configurame las teclas.
        // console.println("INICIE CONTORLES")
      //movimientos jugador meter limitaciones y q no salga del mapa , y solo ubicar en  donde se pueda situar 
        keyboard.up().onPressDo({personajePrincipal.moverseHaciaArriba()})
        keyboard.down().onPressDo({personajePrincipal.moverseHaciaAbajo()})
      //teclas de opciones torres 
          keyboard.space().onPressDo({personajePrincipal.agregarTorre()}) //Z para poner la torre normal 
      //teclas opciones
          keyboard.w().onPressDo({torresOpciones.moverseHaciaArriba()})
          keyboard.s().onPressDo({torresOpciones.moverseHaciaAbajo()})
      }
  }
    method controlesIntro() {
        keyboard.space().onPressDo({secuencia.saltar()})
    }
    //Manejo del menu mediante teclas
    method configurarTeclaMenu() {
        keyboard.i().onPressDo({menu.verNiveles()})
        keyboard.p().onPressDo({menu.iniciarTutorial()})
        keyboard.m().onPressDo({menu.verControles()})

  }
    method teclasSelecNiveles() {
      if(!juegoDelCastillo.juegoCorriendo()){
          keyboard.num1().onPressDo({menuNiveles.iniciarNivel(0)})
          keyboard.num2().onPressDo({menuNiveles.iniciarNivel(1)})
          keyboard.num3().onPressDo({menuNiveles.iniciarNivel(2)})
      }
  }
  method configurarTeclaMenuOver() {      
    if(!menuGameOver.overActivo()){   // si ya se activó el menu game Over, entonces No volver a configurar.
      keyboard.i().onPressDo({menuGameOver.verNiveles()})
      keyboard.r().onPressDo({menuGameOver.reiniciarPartida()})
    }
  }
  method configurarTeclaSiguienteOver(){
//    if(!juegoDelCastillo.juegoCorriendo()){
      keyboard.e().onPressDo({menuNextLevel.iniciarSiguienteNivel()})
      keyboard.r().onPressDo({menuGameOver.reiniciarPartida()})
//    }
  }
}

//Forma de conseguir siguiente posiciones hacia cada direccion y sus diagonales, seguramente solo se vaya a usar para las torres
object arriba {
  method siguientePosicion(pos) = pos.up(1)
}
object abajo {
  method siguientePosicion(pos) = pos.down(1)
}
object izquierda {
  method siguientePosicion(pos) = pos.left(1)
  method diagonalInferior(pos) = abajo.siguientePosicion(self.siguientePosicion(pos))
  method diagonalSuperior(pos) = arriba.siguientePosicion(self.siguientePosicion(pos))

}
object derecha {
  method siguientePosicion(pos) = pos.right(1)
  method diagonalInferior(pos) = abajo.siguientePosicion(self.siguientePosicion(pos))
  method diagonalSuperior(pos) = arriba.siguientePosicion(self.siguientePosicion(pos))

}