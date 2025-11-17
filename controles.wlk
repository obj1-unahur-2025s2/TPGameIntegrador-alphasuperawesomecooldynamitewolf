// //Copié todo lo relacionado a controles acá... no discriminé nada.. Despues lo pulimos para usarlos desde aca. Por ahora no quiero romper nada. Por eso no toco nada del codigo real.
import menu.*
import juegoBase.*
import castillo.*
import niveles.*


object controles {
    method configurarTeclas() {
    //movimientos jugador meter limitaciones y q no salga del mapa , y solo ubicar en  donde se pueda situar 
	    keyboard.up().onPressDo({personajePrincipal.moverseHaciaArriba()})
	    keyboard.down().onPressDo({personajePrincipal.moverseHaciaAbajo()})
    //teclas de opciones torres 
        keyboard.space().onPressDo({personajePrincipal.agregarTorre()}) //Z para poner la torre normal 
    //teclas opciones
        keyboard.w().onPressDo({torresOpciones.moverseHaciaArriba()})
        keyboard.s().onPressDo({torresOpciones.moverseHaciaAbajo()})

  }
    //Manejo del menu mediante teclas
    method configurarTeclaMenu() {
        keyboard.i().onPressDo({menu.verNiveles()})
        keyboard.p().onPressDo({menu.iniciarTutorial()})

  }
    method teclasSelecNiveles() {
        keyboard.num1().onPressDo({menuNiveles.iniciarNivel1()})
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
  method diagonalInferior(pos) = self.retorno(abajo.siguientePosicion(self.siguientePosicion(pos)))
  method diagonalSuperior(pos) = self.retorno(arriba.siguientePosicion(self.siguientePosicion(pos)))
  method retorno(pos)= [pos.x(),pos.y()]
}
object derecha {
  method siguientePosicion(pos) = pos.right(1)
  method diagonalInferior(pos) = self.retorno(abajo.siguientePosicion(self.siguientePosicion(pos)))
  method diagonalSuperior(pos) = self.retorno(arriba.siguientePosicion(self.siguientePosicion(pos)))
  method retorno(pos)= [pos.x(),pos.y()]
}