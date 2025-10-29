import juegoBase.*
import castillo.*
import wollok.game.*

class Nivel{
    var nivel
    var enemigosPorOleada 
    var enemigosGenerados
    var enemigosVivos                 //x,y
    const ubicacionesPosiblesDeTorre=[[5,4],[8, 3],[11, 0],[14, 2],[16,1],[18,6]] //debe estar ordenada 
    const ubicaionActualJugador =[] 
    // Inicializa el nivel
    method iniciar(){
        
        game.addVisual(personajePrincipal)
        game.addVisual(castillo)
        enemigosGenerados = 0
        enemigosVivos = 0
        self.generarOleada()
        
    }
    method ubicaionActualJugador() =ubicaionActualJugador 
    method ubicacionesPosibles() =ubicacionesPosiblesDeTorre 
    method ubicacionSiguienteA(pos) {
        ubicaionActualJugador.add(pos)
        console.println(ubicacionesPosiblesDeTorre)
        console.println(ubicaionActualJugador)
        console.println(self.restaDeUbicaciones())
        return self.restaDeUbicaciones().get(0)
    }
    method obtenerUltimo() =ubicaionActualJugador.last()
    method ubicacionAnterior(pos) {
        const moverse=self.obtenerUltimo()
        ubicaionActualJugador.remove(self.obtenerUltimo())
        return  moverse
    }
    method restaDeUbicaciones() =ubicacionesPosiblesDeTorre.filter({u => not self.ubicaionActualJugador().any({ub=> ub ==u})}) //filtra por los que NO estan en las lista de la lista de posiciones del jugador
    method generarOleada(){
        if(enemigosGenerados < enemigosPorOleada){
            enemigosGenerados += 1
            enemigosVivos += 1
        }
    }

    // Llamar cuando un enemigo muere
    method enemigoMuerto(){
        enemigosVivos -= 1
        if(enemigosVivos == 0){
            self.pasarSiguienteNivel()
        }
    }

    method pasarSiguienteNivel(){
        nivel += 1
        enemigosPorOleada += 2  // Cada nivel más difícil
    }

    /*method nivelFinal(){
        if(nivel == 10){

        }
    }*/
}


///usos, se podria utilizar para saber cuantas torres hay para ubicar,  si es que en algun nivel especifico ya no se permite dicha torre etc.
object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const torres=[]
    method iniciar() {

        const torreNormal=new Torre(nivelTorre=1,costo=2,daño=10,position=game.at(0,0)) //al iniciar las opciones se guardan en la lista las torres 
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=4,daño=10,position=game.at(0,0))
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)
    }    
    method obtenerTorreNormal() = torres.get(0)
    method obtenerTorreCañon() = torres.get(1)

}
//---------(Entorno)--------
const nivelPrueba = new Nivel(nivel=0,enemigosPorOleada=0,enemigosGenerados=0,enemigosVivos=0) //un nivel para probar diseños. --cambiar a tutorial mas adelante
