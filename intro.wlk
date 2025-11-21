import wollok.game.*
import pantalla.*
import controles.*
import menu.*

class Intros{
    var property position =game.origin()
    const imagen
    method image() = imagen
    method iniciar()
}
object intro1 inherits Intros (imagen = "intro1.jpeg"){
    override method iniciar(){
        controles.controlesIntro()
        game.addVisual(self)
    }
}
object intro2 inherits Intros (imagen = "intro2.jpeg"){
    override method iniciar(){
        game.addVisual(self)
    }
}
object intro3 inherits Intros (imagen = "intro3.jpeg"){
    override method iniciar(){
        game.addVisual(self)
    }
}
object secuencia{
    var lastVisual = null
    var property position =game.origin()
    const frames = [intro1, intro2, intro3]
    method saltar(){
        if(lastVisual != null) game.removeVisual(lastVisual)
        if(frames.size() > 0){
            lastVisual = frames.first()
            frames.first().iniciar()
            frames.remove(frames.first())
        }
        else{
            lastVisual = null
            game.addVisual(menu)
            menu.seleccionNivel()
        }
    }
}