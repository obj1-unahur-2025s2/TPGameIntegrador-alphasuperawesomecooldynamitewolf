import pantalla.*
import niveles.*
import controles.*
import juegoBase.*
import armas.*


object menu {
    const menu =[[7,1],[11,1]]
    const niveles=[]
    const menuElementos=[] //se agrega las imagenes "entrenamiento" "iniciar" <- podria estar en una sola imagen, pero para animarlo estaria bueno que esté separado.
    var property position =game.at(0,0) 
    method image() ="juegoInicio.jpeg" 
    
    method seleccionNivel() {
        controles.configurarTeclaMenu()
        const selectorNiveles= new Pantalla(imagen ="selectorNiveles.png" , position=game.at(20,20))
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const entrenamiento = new Pantalla(imagen="maniqui.png" ,position=game.at(self.entrenamientoPosition().get(0),self.entrenamientoPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(entrenamiento)

        menuElementos.add(play)
        menuElementos.add(entrenamiento) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.

    }
    method terminarMenu() {
      menuElementos.forEach({e => e.eliminar()})
      game.removeVisual(self)
    }
    method estaActivo() =menuElementos.size()>0 //esta activo si hay elementos dentro del menu. osea el menu esta activo. 
    method verNiveles() {
      
      niveles.add(nivelPrueba) //<- agregar la lista de todos los niveles, menos el tuto [nivel1,nivel2..]
      menuNiveles.iniciar()
      self.terminarMenu()
    }
      method iniciarTutorial() {
      
      juegoDelCastillo.agregarNiveles(nivelPrueba) //<- agregar la lista de todos los niveles, y al principio el tuto [tuto,nivel1,nivel2..]
      self.terminarMenu()

      juegoDelCastillo.iniciarNivel()
      game.removeVisual(self)
      
    }
    method niveles() =niveles 
    method playPosition() =menu.get(0) 
    method entrenamientoPosition() =menu.get(1) 
}
object menuNiveles {
  var property position =game.at(0,0) 
  method image() = "selectorNiveles.png"
  method iniciar() {
    game.addVisual(self)
    controles.teclasSelecNiveles()
    //todavia no interactua con los niveles.

  }
  method iniciarNivel1() {
    juegoDelCastillo.agregarNiveles(nivelPrueba)
    juegoDelCastillo.iniciarNivel()
    self.terminarMenuNiveles()
  }
  method terminarMenuNiveles() {
    game.removeVisual(self)
  }
}