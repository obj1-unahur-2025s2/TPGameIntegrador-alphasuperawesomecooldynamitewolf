import pantalla.*
import niveles.*
import controles.*
import juegoBase.*
import armas.*

class Menu{
    const menu =[]
    const niveles=[]
    const menuElementos=[] //se agrega las imagenes "entrenamiento" "iniciar" <- podria estar en una sola imagen, pero para animarlo estaria bueno que esté separado.
    var property position =game.at(0,0) 

    const imagen
    method image() =imagen 
    method seleccionNivel()
    method terminarMenu() {
      menuElementos.forEach({e => e.eliminar()})
      game.removeVisual(self)
    }
    method estaActivo() =menuElementos.size()>0 //esta activo si hay elementos dentro del menu. osea el menu esta activo. 
    method verNiveles() {
      juegoDelCastillo.vaciarNiveles()
      niveles.add(nivelPrueba) //<- agregar la lista de todos los niveles, menos el tuto [nivel1,nivel2..]
      menuNiveles.iniciar()
      self.terminarMenu()
    }
}
object menu inherits Menu(menu =[[7,1],[11,1]],imagen="juegoInicio.jpeg") {

    //esto habilita imagenes dentro del entorno.
    override method seleccionNivel() {
        controles.configurarTeclaMenu()
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const entrenamiento = new Pantalla(imagen="maniqui.png" ,position=game.at(self.entrenamientoPosition().get(0),self.entrenamientoPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(entrenamiento)
        menuElementos.add(play)
        menuElementos.add(entrenamiento) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.
        
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


object menuGameOver inherits Menu(menu =[[7,1],[11,1],[7,4]],imagen="filterOver.png") {
    var overActivo=false // <-es utilizado para que la tecla Riniciar no sea ejecutada  varias veces. (ya que al inovcar seleccionNivel este llama a configurar su teclas.)
    //esto habilita imagenes dentro del entorno.
    override method seleccionNivel() {
        controles.configurarTeclaMenuOver()
        const gameOver= new Pantalla(imagen="gameOver.png", position=game.at(self.gameOverPosition().get(0),self.gameOverPosition().get(1)))
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const reiniciar = new Pantalla(imagen="reiniciar.png" ,position=game.at(self.reiniciarPosition().get(0),self.reiniciarPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(reiniciar)
        game.addVisual(gameOver)
        menuElementos.add(play)
        menuElementos.add(gameOver)
        menuElementos.add(reiniciar) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.

    }
    method overActivo() =overActivo 
    override method verNiveles(){
      juegoDelCastillo.vaciarNiveles() //
      menuNiveles.iniciar()
      self.terminarMenu()
      
    } 
        
    method reiniciarPartida(){ //metodo Exclusivo de la tecla R.
      overActivo=true // impide que la tecla reiniciar se pueda ejecutar de nuevo. Ya que la tecla reiniciar ya está en uso. 
      juegoDelCastillo.reiniciarPartida()
      self.terminarMenu()
    }    

    method niveles() =niveles 
    method playPosition() =menu.get(0) 
    method gameOverPosition() =menu.get(2) 
    method reiniciarPosition() =menu.get(1) 

}


object menuNiveles {
  var property position =game.at(0,0) 
  method image() = "selectorNiveles.png"

  method iniciar() {
    if(!game.hasVisual(self)) game.addVisual(self)
    controles.teclasSelecNiveles()
    //todavia no interactua con los niveles.

  }

  method iniciarNivel1() {        
    if(!juegoDelCastillo.tieneNiveles()){
      juegoDelCastillo.agregarNiveles(nivel1)
      juegoDelCastillo.iniciarNivel()
      self.terminarMenuNiveles()
    }
  }
  method iniciarNivel2() {
    if(!juegoDelCastillo.tieneNiveles()){
      juegoDelCastillo.agregarNiveles(nivel2)
      juegoDelCastillo.iniciarNivel()
      self.terminarMenuNiveles()
    }
  }
  method iniciarNivel3() {
    if(!juegoDelCastillo.tieneNiveles()){
    juegoDelCastillo.agregarNiveles(nivel3)
    juegoDelCastillo.iniciarNivel()
    self.terminarMenuNiveles()
    }
  }
  method terminarMenuNiveles() {
    game.removeVisual(self)
  }
}