import castillo.*
class Nivel{
    var nivel
    var enemigosPorOleada 
    var enemigosGenerados
    var enemigosVivos
    
    // Inicializa el nivel
    method iniciar(){
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