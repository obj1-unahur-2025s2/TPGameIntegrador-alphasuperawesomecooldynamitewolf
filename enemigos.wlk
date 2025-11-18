import armas.*
import castillo.*
import wollok.game.*
import juegoBase.torresOpciones

//const enemigo1 = new Enemigo(posiciones = nivelPrueba.ubicacionesCamino()) Ejemplo de como tendría que ser la instanciación de los enemigos con los demas atributos

class Enemigo{
    var vida //diferencias de vidas y hits
    const property daño
    var rango
    var imagen //variar al recibir un ataque
    const posiciones
    const nivelAct
    var property position =game.at(0, 0)
    const posicioActual=[]
    method posicionActual() = game.at(posicioActual.last().get(0),posicioActual.last().get(1))
    method recibirDaño(cantidadDaño){
        if(self.estaVivo()){
            vida -= cantidadDaño
            
            ///game.say("Me queda" + self.vida()) /// Revisar por las dudas
        }
        else{
            self.morir()
        }
    }

    method vida() = vida
    method image() =imagen
    method iniciar() {
        self.avanzar()
    } 
    method avanzar() {
        if(posiciones.size() !=0){//caso base, ya no hay posiciones.
         
            position=game.at(posiciones.first().get(0),posiciones.first().get(1))
            posicioActual.add([position.x(),position.y()]) // agrega esa posiciosion -> por si la torreta quiere saber donde está , sirve esto , solo falta un  getter
            posiciones.remove(posiciones.first()) // remueve su primera posicion
            game.onCollideDo(self, {torre=>self.avanzar(); torre.atacarEnemigo(self)})
            console.println(vida)
             
            game.schedule(1200, { self.avanzar()}) // activa recursion
        }
    }
    method morir(){
        self.soltarMoneda()
        game.removeVisual(self)
        
    }
    ///Hay que ponerle un limite de que parte del juego deberia aparecer aleatoriamente
    method soltarMoneda(){
        personajePrincipal.recogerMonedas(self.valor())
    }

    method estaVivo() = vida > 0

    method recibirDaño(){
        if(self.estaVivo()){
            vida -= 3
            console.println(vida)
        }
        else{
            self.morir()
        }
    }

    method atacar(unObjeto){
        unObjeto.recibirDaño(daño)
        game.say(unObjeto, "Me queda" + unObjeto.vida()) /// Revisar por las dudas
    }
    
    method valor() = 5
    
}

///Opcion un jefe final poderoso, lo hago objeto por que es uno solo por el momento 

class JefeFinal inherits Enemigo{
    override method valor() = 10
}
//para ver posiciones, borrar si hace falta:
object map {
  var property position =game.at(14,5) //14,5
  method image() ="idlTroll.png" 
}

/*
¿Movimiento inteligente de Enemigo?:        ==> Algo que me gustaría implementar si puedo
- El enemigo debe saber su propia posición
- El enemigo debe saber la posición del castillo
- El movimiento del enemigo debe consistir en intentar reducir la diferencia entre su posición y la del castillo (se puede utilizar su valor absoluto)
- Función con lista de movimientos: Izquierda, Arriba, Derecha, Abajo.
    Con eso va guardando la posición anterior (para no regresar sobre sus pasos)
    Va a ir probando de las 3 posiciones restantes (no cuenta por donde viene) y evalúa donde está la siguiente instancia de "camino"
- clase camino va a ser un objeto invisible que se coloca para delimitar el camino que va a poder recorrer el enemigo. Si no hay objeto no puede moverse
*/