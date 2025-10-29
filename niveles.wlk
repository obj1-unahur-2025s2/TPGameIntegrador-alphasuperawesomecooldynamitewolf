import juegoBase.*
import castillo.*
import wollok.game.*

class Nivel{
    var nivel
    var enemigosPorOleada 
    var enemigosGenerados
    var enemigosVivos
    
    // Inicializa el nivel
    method iniciar(){
        game.addVisual(personajePrincipal)
        game.addVisual(castillo)
        enemigosGenerados = 0
        enemigosVivos = 0
        self.generarOleada()
    }

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

        const torreNormal=new Torre(nivelTorre=1,costo=10,daño=10,position=game.at(0,0)) //al iniciar las opciones se guardan en la lista las torres 
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=10,daño=10,position=game.at(0,0))
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)
    }    
    method obtenerTorreNormal() = torres.get(0)
    method obtenerTorreCañon() = torres.get(1)
}
//---------(Entorno)--------
const nivelPrueba= new Nivel(nivel=0,enemigosPorOleada=0,enemigosGenerados=0,enemigosVivos=0) //un nivel para probar diseños. --cambiar a tutorial mas adelante
